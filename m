Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041FEC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiWQ-0006gG-SJ; Fri, 04 Jul 2025 11:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiWO-0006ee-Bh
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiWJ-0008JV-6C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751643610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KwoJRUBSCBq6WjC8HZFa0ComJJ/+0JgF4Vi6jnOwbqk=;
 b=Heh6k0AqevFUrfSCVYuI+bw77QI/IYEwC+c9Q08krev4C7yt1dXWwODFtdhuULe3mP2UGw
 lrDlu+UPMhEt0pFWtawZuTCm0mXD16obnBJY53WFFAp8yUlmP4V9WyI5k3JpOT4jsL5U9n
 WIw6v8u3TnjunfW1y2TRDvdOcirWpW4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-hWdWEzTxNc2o2V1mkqUKNA-1; Fri, 04 Jul 2025 11:40:09 -0400
X-MC-Unique: hWdWEzTxNc2o2V1mkqUKNA-1
X-Mimecast-MFC-AGG-ID: hWdWEzTxNc2o2V1mkqUKNA_1751643608
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fb520a74c8so20393566d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643608; x=1752248408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwoJRUBSCBq6WjC8HZFa0ComJJ/+0JgF4Vi6jnOwbqk=;
 b=n4znPXOWMjCUexotiEt+Rgcii/2FKdbmBA5UmvpyxZBId51RHwSC2CM746k/GXPAoR
 PNOlA/RklBjCBIpNkXhoSy7z2PYPc4CgLcg6OiKY1vt+4hdQl33k1SSbMhMQ1pHQS8gx
 IgujEv0euscKRBvtwTQmTb8zCUoHPMacZmvS8EREKfY6yT6Ks/SzqFBwXqzEowPQEMeW
 6WgU4Rk1yiTuVxGl30ukpSsCLkj1VFHYlZ1JfixH9U1R5qV5/E2tTjPNhGuPhsK3Dv6p
 br7JTwII9rTQEFq1A7CcwatgCVplP105Cx8mOOxTvSpKw5BeyA2fn2KnlZmQh7HBt4AA
 3QTw==
X-Gm-Message-State: AOJu0YxQBx56vGaTvkY27DUouBQ9QDm4eRtrBdYduTaqkAcjMfHySx2/
 AeKkc8O4G8GOHwd9xT+Pqk5N/SzHNPyvc70aBYHBOMhgc2x6HCsPyJynCDPUEe9mSBu90hm+ETO
 BPQjzclYBNrqfkvPi7UqN60LrV1EO/QGstCHLpy8dJlRENFEldBcciz54
X-Gm-Gg: ASbGnctcInJrlTfyF7uUmZMclJeUXjNGpFqfdFMnNNFv6qWNYQOfMk0bQgJ8fszfMH1
 umJN0FgdyiRgx6adITpfFoC35fcFU/iZYsY06eFQbS/Jo5H8KGC9TomPEGrEh+goHPJ4x6oqlAx
 Ynl4vg+Mi6QzJpqTIxQTe7B3reNev0IdnKjsUBnFhWwxH8ZPtmOalLJ784OTGwGVytLj0obm4g/
 JIQdjv9ngSHb4vIIp2Xxt6wUcmE2rW5bQcbqUoqma+JfrNghLIdb3z4svLVHMA5bGXnPHWBU4Wn
 eqMkfSNXh6A7qw==
X-Received: by 2002:ad4:5748:0:b0:6fb:23:4812 with SMTP id
 6a1803df08f44-702c6d79c3cmr38669896d6.26.1751643608488; 
 Fri, 04 Jul 2025 08:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHyV+DYlxXxR/Hsc0VCXEwvbUQ1SPqX09lwT/gvFZToVaNplukHKeh67A7B0mpjSL1ocy2hA==
X-Received: by 2002:ad4:5748:0:b0:6fb:23:4812 with SMTP id
 6a1803df08f44-702c6d79c3cmr38669546d6.26.1751643608104; 
 Fri, 04 Jul 2025 08:40:08 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d5ad73sm13913356d6.92.2025.07.04.08.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:40:07 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:40:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 05/24] qapi/migration: Don't document MigrationParameter
Message-ID: <aGf11QfMvAGE8Amw@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 30, 2025 at 04:58:54PM -0300, Fabiano Rosas wrote:
> The MigrationParameter (singular) enumeration is not part of the
> migration QMP API, it's only used for nicely converting HMP strings
> into MigrationParameters (plural) members and for providing readline
> completion.
> 
> Documenting this enum only serves to duplicate documentation between
> MigrationParameter and MigrationParameters.
> 
> Add an exception to QAPIs pragma.json and stop documenting it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


