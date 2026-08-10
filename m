Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32CDC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUel-0000AB-Rx; Mon, 10 Aug 2026 14:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtUek-00009u-4c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wtUei-000482-JZ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wAWkcUsMhtOaulzd4CCD8embZ0C9/0WJObRntVf4Tmc=;
 b=i/BSEb0P15KnIBY5UJF/jLxFGwxJ2bn8c4jx2chK/Wy7CM+N9OE0MyrWEacqlofyaipSuj
 hE3N7shLJUTFKwATrBa7ugSzt4zRCNGqfEUg3XeDSSIq+Nq3Eu3FFJ5nJEuQZiMbAWvQzi
 DU8/B0anrb4GawNFcazTwtkgko4j6vo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sRpwoaHWNTSsc7_aZawvIw-1; Mon, 10 Aug 2026 14:23:21 -0400
X-MC-Unique: sRpwoaHWNTSsc7_aZawvIw-1
X-Mimecast-MFC-AGG-ID: sRpwoaHWNTSsc7_aZawvIw_1786386201
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so215571685a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786386201; x=1786991001; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wAWkcUsMhtOaulzd4CCD8embZ0C9/0WJObRntVf4Tmc=;
 b=rNYIPJq851K2YiGLc+WgZfQqYKI7f9Js/pfuht9afVq0cf8zBC2J1PQE/QyS1wwvrZ
 x9XeLqE5jU84pLu5Zjm5hyOiNBlcg/bKJtTfjKaRtZTCQRdw91n1eM29z6EKcRwmVrLh
 1t4yaI0deV6sH777RqnUoYatbGSbaOh9jmsafRqNdOgRIvfiqZ7h7tlVttUiDFp1rgo/
 szNSN17KZC1r6OnPG8tiXsmOiHcUz/MpIPGavvQOKPc9pV4vu13juonUzIsUwmci+H+k
 oije5TIX7d5rsUBHQ8s5oq1/iWIgraD1GaYLhsJSynl7m1ENIp3LUf2vjlfKEVvrXyL3
 /FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786386201; x=1786991001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wAWkcUsMhtOaulzd4CCD8embZ0C9/0WJObRntVf4Tmc=;
 b=n4V23ehca+3qhwybbSKlXpvMfk/MST5O7GGGRXngExFd5oNmiZyv30dswmpN//54dX
 46BC6SDrjf0fn+0yTrisjj4UxWYjeotPFEThtsgOKgaJWHtwnESGtF/WMTTbvzKbPkBc
 baYDUN4dddLkkV8UreUC6gOdKgQDMNwZOLYNrijkIQMB/T1s7bEejTvWo9CBvaP5tUS6
 jwUPSeezdXt99caXqvuinf0+CXYvf1ZP8ytJFGrMiHpv2UTO3mzdyMmjpijrdX6kEPGN
 nIuokYEsDEXl5mVeDfyqWm1ENbYxeOCox0oQ5CL8JMRtB3nPiImQOWhDUag3J+8s/374
 8DQg==
X-Gm-Message-State: AOJu0YzKrsozdTtYBETUkr879BOlhMzo1x1RN5JVW2ptTPl1R18sNc/d
 /mUuFssgmew/ESLbGQ+DOTBEN6lICf9rYbrzayx3Tr9sa5KgLyAeQhocjfgs2T7l6nKm6K8vlNX
 SvdaSqAOL0EBMkKsmgwVXle1j+aPUNM0c2UV6knYOLtv8JlF4+nKxYvWR
X-Gm-Gg: AR+sD13RZU2gjSLfybAEWC4+3J0tfj+Bcwm23gX4mxnCevgxQy3P3rqco3RdoowVZev
 BA8UOPr0zx6HkmVYVYMoYI/F6akZiySaVkZf0KH73uq/toucrokJtDdXN16rgaQsqibDDsW5ksH
 H8x9djXMqjh3Z7v2n9wolEwPCDnEMvIckGlXaNV+icCUmt7WOnoQ6/KHOI2vHr3iGFfDjwFh513
 GML0kRh6iebmZh3PK/7RT1Z+N/4pk7h9wjVIFpDM3JgSnn/n9xwbseccwKfGIZcFVuz3vsSEfBa
 erfhvlkroYM709EdFUqaDJfk8Lhw5/oVPD5OSbEzJMZo15mntH7XXNCnjSa1tN0/842K
X-Received: by 2002:a05:620a:371c:b0:932:db43:7286 with SMTP id
 af79cd13be357-9369cf10d98mr394140885a.8.1786386200775; 
 Mon, 10 Aug 2026 11:23:20 -0700 (PDT)
X-Received: by 2002:a05:620a:371c:b0:932:db43:7286 with SMTP id
 af79cd13be357-9369cf10d98mr394133385a.8.1786386200139; 
 Mon, 10 Aug 2026 11:23:20 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936a14f7e9dsm31560685a.23.2026.08.10.11.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:23:19 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:23:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 09/11] migration: update capability conflict test for
 postcopy-ram+mapped-ram
Message-ID: <anoXE6YAQFI-6R5N@x1.local>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-10-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-10-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On Sat, Aug 01, 2026 at 08:06:26AM +0530, Aadeshveer Singh wrote:
> Remove the test test_validate_caps_pair, which asserted postcopy-ram
> and mapped-ram capabilities cannot be active together. The new fast
> snapshot load feature is exactly this pair of capabilities active
> together, with the following patches in this series, this combination
> will now supported and be functional.
> 
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load.
> 
> Add a capability check against setting multifd when configured for fast
> snapshot load as it is not supported yet. Also add capability check
> against setting postcopy-preempt as it is incompatible.
> 
> Add infrastructure to check postcopy_notifier_list being empty in
> capaility checking to block vhost-user with fast snapshot load as it is
> not supported.
> 
> A smoke test exercising this feature has been added further in this
> series.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


