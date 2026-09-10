Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B346BC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ijj-00047S-Nv; Thu, 10 Sep 2026 13:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4ijg-00045j-2W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4ije-0004yt-G2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789061933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipMeNdh4qvXcyxKfamaYVwbkJyi9XBAxU4MnGdxu/m8=;
 b=h3X2PiqPmcijOc9FNRv2/QsE95u9Sup4RWSTq+QnvrLh4Z0qNOATDbgJnA+WnKfALiMlXV
 L6k4RFg6Sp6DZgpY8Eb3hNPl/Zy8keouc0Wf0+u0OJn4AC1mboufI2hife9Q6fNqDK7Oqm
 wIVVz6hWFb3qvj66jNsSWsINAWn2Yi4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-xJJxdVy5NXG18RVwyUSA8w-1; Thu, 10 Sep 2026 13:38:51 -0400
X-MC-Unique: xJJxdVy5NXG18RVwyUSA8w-1
X-Mimecast-MFC-AGG-ID: xJJxdVy5NXG18RVwyUSA8w_1789061931
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c8da50f4fso100639606d6.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789061931; x=1789666731; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ipMeNdh4qvXcyxKfamaYVwbkJyi9XBAxU4MnGdxu/m8=;
 b=jWHKVEbVf0B0jsuKMagV1beDXibtLEqJSbDgX9u1zGjvTVg7N8ih3fP00t6FwAUySa
 sGvG4c8R02w2YtyRCxBXsvW4726cmKFLHr2SAxctnDJwXW5m+LUHCuckYn1Pi1SXFApJ
 FTxTmnCoiRhzezdnuWpbE3sAGZ+r8YFT9U1q6o2AuHeYyQFimw/q1s7koChhJI1QCVPu
 ml8Aj5ks0OQFt9vtVmZD6fDyNTtqPwMVB2sp2W4OoIqBb6HwmuwzRfn9UfmNbKBPzmKI
 ZfS7/QtxEQzNpc0j6eGKQEJVAeAPRWaVvWf04n/UKMWPL/EPeh3GhQ6kkaQ3TGN7SvEv
 B5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789061931; x=1789666731;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ipMeNdh4qvXcyxKfamaYVwbkJyi9XBAxU4MnGdxu/m8=;
 b=BgRj/2g87Ral38e3ekjR3o8ZSzSIUDM57s9TDEue7/49Yes37tN4hpd2QhIBmL1c6Q
 8t7TkzJ2zY3k5kJFPPVv/1kfWNKQd7/4tr6tMh9BbssyA4L5cUI5zPNruhGwvCGkXCS8
 2ayQSafUhRO4YBjFct7OKbg7FD05VIo2Y2QEFQkTSis0kB57NefN9xq6NRrZy9Ekrz0e
 wmWI/nChLJreoSjuYsYeILjCJVAwx5J5Qtc2KlthkNtRybYKrJK28SojxRr0pP/v6+xH
 cBcP0LB0C5ZceKdHdxkyqIlOTbVosaIhH65pbcFtDaeLGg24ipBqs69vyPWUPXIds3f5
 tmuA==
X-Gm-Message-State: AFuF++kbyvZgtJzjrna5IPxQ8GaRFHWJuWmnWXfygaRruW696r1jruA9
 tfsjHpXX2nUGvJRHbxjzjHMN4AkkzukcWviGjJrAqdj34fLEOXczTT+vNWm9yAntHIq1lIzwGbj
 qRkFJ9Sg68jBAWr9MXp8idcy24yZVyIDFSVeRcg/DRN4GSuccTZMBEUPw4zjLBh+69LY=
X-Gm-Gg: AYBFou3yzS3pzutmAS/EKXqr+esj3OWtWx5NcHJHOuCF21/Il0A3PZxh0ARmsP+dqR3
 2F4GuCeGFr9y7GzOwdUmSmN93BD3Q2hGXPfMv3Ks0Zb1oXzTIU+mq4PIEwAmvXPrL2Q8FkVCtlY
 Hw78i1QHAHNJD7kFi9riH6ku1xeKNQzfK1ZorhBjPl64sKw5CDkqWKGItkW12Ynr4UB26dbER/l
 ZI34KKMDuBB3SNiUzPUw7FLkPWjQUn+ka48bkZm+7oAOI5aKdFB6LaKOiy0uSFFN7LhqTg2sycQ
 NC3xj/wWEytdEPDqDn/8xyvyuNRa0ftx6dx/5d8pP2h33gbCQ0BhtU0bwYv8MdZSceRd
X-Received: by 2002:a05:6214:2126:b0:8f3:13e4:739d with SMTP id
 6a1803df08f44-9103efc8e89mr525544406d6.7.1789061931188; 
 Thu, 10 Sep 2026 10:38:51 -0700 (PDT)
X-Received: by 2002:a05:6214:2126:b0:8f3:13e4:739d with SMTP id
 6a1803df08f44-9103efc8e89mr525543896d6.7.1789061930603; 
 Thu, 10 Sep 2026 10:38:50 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f45ab7csm1180906d6.15.2026.09.10.10.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:38:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:38:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/18] migration: HMP: Fix bandwidth parameters
Message-ID: <aqLrH5kky1FVngCg@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 09, 2026 at 06:45:01PM -0300, Fabiano Rosas wrote:
> The max-bandwidth and avail-switchover-bandwidth parameters are
> declared as bytes/second in migration.json and interpreted as such
> throughout the code, except in HMP where they're expected to be
> provided as mebibytes.
> 
> Fix the HMP code to parse the values as bytes.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


