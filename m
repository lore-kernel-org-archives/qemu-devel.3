Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C709CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0XY-0005sl-ID; Tue, 09 Sep 2025 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0XO-0005oU-GE
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0XD-0006Pp-A8
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757432727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8sRzIATr3LK9MwHfExvPLjD2IBArg8pezleclUfHOI=;
 b=RgMlYgU4GK4Tn2bORgReFIENWJqBgwSOKPXJvuSalsQtBPizWlWQtdokfpFrG9uQshwoDb
 Y21M1VdUHvzG+SjVKfwG8sOGp5UAccUZrbd5I7gUfxyEBsRY5LV5+5eOcK/CHieN8x5vSc
 gcedu3CHrYZ4ZvszWTy/JY77Fq0rMA0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-OH_-rNdHNCWyUnLwvplP-A-1; Tue, 09 Sep 2025 11:45:26 -0400
X-MC-Unique: OH_-rNdHNCWyUnLwvplP-A-1
X-Mimecast-MFC-AGG-ID: OH_-rNdHNCWyUnLwvplP-A_1757432725
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-718c2590e94so158683456d6.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432725; x=1758037525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8sRzIATr3LK9MwHfExvPLjD2IBArg8pezleclUfHOI=;
 b=AEuEeVZ+y6VKDRBqQBuQiqTrHJyrvGwmEpTYWOH+7SJGoGyGZUIyEcZ0x1Z+6S5Q8W
 uavzPf/j5/Sg9DRqIE4tB5WW0Hu4VUsV2JtiMkOOwPiQX0vAG6GWbXUwk6DL7OviUTco
 R+oVpAN3IVQ6gmmXw+WivIThchsL04/Nu3WpM6hIf4b5Hl0RYZx5Fv5OfluF26Mm3gpL
 gpF0KbRpTpQNALHzdf1FBEMbZsQStl4z3gMg/nRFSanlC6/E/0dOEbl09P+9CjXOd6pS
 Lz7OpMOkR+J1Vep8oCKGRVqLkwjdcGHtz1XZeW0tdQnQXbyDPjxMQBlsJloFtPdHn3Bh
 c56g==
X-Gm-Message-State: AOJu0Yyn4CIPzJl3EdexbnGqBRrlYSmhYK9STqFtYMSIubvrTcYW4OPR
 v4U+GgxQbvGMrCZXV1kIwKqEoSWJtKiwSa2lqqqJX/tXro5JXhXWIyM7i8/zwtDQkMEv50lgMfp
 rg4ECYfdkOf4AgEtGwYa8baCnjwo122dsjiyEBJ4FZhonXmwY55tMUq27
X-Gm-Gg: ASbGnctGw2NvJRf0mCNpEpqlL9RaLScJRneZtDcuEWrZqeIn1CEIbQat+YxBijGkvJL
 +hYHyCRedvdNjm6B0WSLdryuSjONQeyqztgE6FWgp7hWYKbUWjfUqWfS1r1nrLDYS59gku9g6IS
 /N6GUIkGRrq+ZNsodlmEUGjhKxAlT7UsblEM9fFFWKl1GCQqvqyfR76ZOUJAqd8irAaFzB5ChL6
 S+vSS/l5LqiuzceGvP0HM2IZ3ANxowEdB08TRqmfNK5LICpfSSoEk1wfRKw6W5NYKIqUHE9nCnH
 HBrkTPR1LnvK9QuByT9NdKPqb7MUunWU
X-Received: by 2002:a05:6214:62c:b0:70d:c230:e4ba with SMTP id
 6a1803df08f44-72bb54cc911mr152139176d6.0.1757432725328; 
 Tue, 09 Sep 2025 08:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUy/i1W++qG1OZnYL8SgCA17dW+0vnUlXU8Q5xGksEIMmqriXeo5Qj21m4LcEi8A/tBE432A==
X-Received: by 2002:a05:6214:62c:b0:70d:c230:e4ba with SMTP id
 6a1803df08f44-72bb54cc911mr152138786d6.0.1757432724896; 
 Tue, 09 Sep 2025 08:45:24 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-728d6f8b338sm112079566d6.0.2025.09.09.08.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:45:24 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:45:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 2/9] migration: add cpr_walk_fd
Message-ID: <aMBLh0iAZmLdQzr7@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 10:17:16AM -0700, Steve Sistare wrote:
> Add a helper to walk all CPR fd's and run a callback for each.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


