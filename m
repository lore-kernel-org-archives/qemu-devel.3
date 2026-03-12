Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0CE105A58D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0eSX-00025q-MV; Thu, 12 Mar 2026 07:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0eSG-00024b-8v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0eSD-0007Br-LR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773315827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VX11yaZ16tzpEGmn6Qq2B8zfb3xH1l4QnXeKAzAzb4c=;
 b=I0mw07LIaGD0EH8O41PJVSFAe964phwJmA9cn3frejiKb8Kehjwgxt0xpW87xtwlgpy1wT
 rz/rAWhDDOFnYcS7brD65SklEbmXpd5DRZ//rHGrRsG9n7yMp7RpDUbr2LBOdaJNT18/hJ
 XQK5+PlAwKZY1xaob8Mok7W8muer4Yk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Qa0fRGByPmqUPVwxoErqPA-1; Thu, 12 Mar 2026 07:43:46 -0400
X-MC-Unique: Qa0fRGByPmqUPVwxoErqPA-1
X-Mimecast-MFC-AGG-ID: Qa0fRGByPmqUPVwxoErqPA_1773315825
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so848556f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773315825; cv=none;
 d=google.com; s=arc-20240605;
 b=Vd/3As1xIRhWBJKU9GcNABRqU5nSi2Ff5qb3lxQ5K9kunkZFt+1NLSkJgZJ+vEBGAo
 RwUH23dIwlzfSHF9FNCcGGxsAiAzh135KSrw1dvWErKNVZs/3qI9VKH6cctBgPMBHEnu
 wPn0aekRmVMtDN6HmcOPRdFlel1Qiw+OshPeUPB9vIWl3UXqLA9Wq7CT/4nutBWTn5xA
 0kvsqJidJTnlPBAGurmKOWSxWP28E2pHLcfnOkouU8eTicGwZ82fdZnJSe9MHWFKGtsc
 YfFzdOdWdnDj4qOzceyey4+W6awlXgXadTcoriqYKer0yc/5xTYHElIcclVGXQc9SYya
 DPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VX11yaZ16tzpEGmn6Qq2B8zfb3xH1l4QnXeKAzAzb4c=;
 fh=bs1X/jfjstA4fyUTOnDQM4b0zYSMu4/5qkbcqtMywgU=;
 b=N62SwqbV6gHiX1LK+jcI2ssf95VUZM/wf6gjAMbP1B1W+10VzNFsnJcPYehSySd97D
 GLg7FgEnGixukawWPbhIB/Mng3705BGJmMGheh2pPKhvp79vsMmMhWdM+uPDFTe3RUaA
 bop/DDfYrchRe8312lLOZQV8ixZH2aJWYB8yzkhpxLUIjcxF5rcTbajnJIRb+NmeOtYD
 sdPacxsJlzZzZq0SwHTq/kyJ3asGojtUl+PMqjRnfaULfXux2/IlUVhRTWUi9wzwal8r
 DByktNrrInjnTNtXDFlItQ3fCVl3KXBlZUeNBN/5kX4ltohyNv0KErSu0WVPZCI7yMI2
 k6wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773315825; x=1773920625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VX11yaZ16tzpEGmn6Qq2B8zfb3xH1l4QnXeKAzAzb4c=;
 b=Asya6vLsngC2C06W+OG06dwYLIwk1hB7A+cs5YiWRiVmo8ksLukpeelnuVNTfFwEtd
 SJ2zXEFdVA2X0R+OdrWQxbo9ivk5ynBViKuSDUbMBAZZqhM3kdWUUPYadXF4umFuMJMd
 mUyZyY8aJXjFzcpVGiWi9rKDmyeRuJgTsL6kOrdm8gg5Rt/9qGyFDnNw6Znli6bZfn/y
 oLXFlU2JqDiyanXutixP4IKubqyp+cqIxT8Jhk8svM8hLmys77vwtWyBmDngOlxszP5D
 PnISCHB4h4ihH8/OoY+KUyFPMqk9paavrsu2/KYmcONsOBESBBL1diDfxXaliDDkDXF+
 liuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773315825; x=1773920625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VX11yaZ16tzpEGmn6Qq2B8zfb3xH1l4QnXeKAzAzb4c=;
 b=Eo6zgeYX2HQwk/p7QbQw243h14mkP2FW4RQivC3uVYwK5JXch4J8hmsksIQq14ZbF/
 VS/oB21oJggE1L0IiVPG1purU6AqJqGHYEo12/zEnHpiht5MhUyWJ92PbFvV83xj1atv
 M4Dm3P/KoYCf1fxtn3CdKtJDEhisOwzMgkqi4/oC36Bc6jP5izCEKsEcJcBjiSVee15x
 s52yf34pakHCjc1+1/tpTYtLNwgnyQtXnKFTB7NXfmCknXGWvt4xPdxS7zgndWMx8cnI
 QJY/dJeFdKIoR0Oj5Re6Irtezv1HG1prEFuDBii5BhCD4WjSKYsYavVeHONZXz8prZW1
 DmRQ==
X-Gm-Message-State: AOJu0Yx2viSfXP1wH3rYp2hzEvimAaMM3RLjTDirGdSfGZb3zEDqq1gd
 ePYaxn1lb0Fw2X+IoNWu+zlGoIvVOixJklLRbRdxa/i+5eROR/7T63s/jBMPkJqOUb1Zaj8BWJW
 XLU2wHlRychP+jFYyL9HPs7xtf6TXYXCPjt1cIEQZ2n4H1CgalEg60JvKmTxtAvu6WbGgJGl5Mj
 Nh/Kscqdv4/GTRFNkQKlxgaEidWlGwVrA=
X-Gm-Gg: ATEYQzwMklQV0ctwlYvwZWp0gKsSgwT5qCtaXOfyBYwIpQ7kWBC+Oqi7P83SlMQczDp
 ANvGq3l73B711/AhPg9ChrYOFtiy3cQDd2gcYjnqMd5CRr9YzXpGCSpOS+/Ykg5uEcNYWdgL/ym
 jBEjiSnTKUV15hAcH0QToWAGBzLe8bE8CSOoDzzQPDV3pVahFM+Tkd0OTWMsaNM3jE8DxlEcCdj
 rUWpnNOHjOEFE71Z+Mp/HwN0oMQxwfeXQIwx8tTsxwsJz74FU7Iv856MlQWlaRqpe1y
X-Received: by 2002:a05:600c:630d:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-4854b10cdb3mr97265225e9.26.1773315825217; 
 Thu, 12 Mar 2026 04:43:45 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-4854b10cdb3mr97264805e9.26.1773315824811; Thu, 12 Mar 2026
 04:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260311131522.58600-1-heifetz@yandex-team.com>
 <20260311131522.58600-2-heifetz@yandex-team.com>
In-Reply-To: <20260311131522.58600-2-heifetz@yandex-team.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 12 Mar 2026 17:13:27 +0530
X-Gm-Features: AaiRm51pVlZmpGRb18wK5WbhHKgGSUJGnc1AVRp--minZf5pKc0pHi9DAArsPMw
Message-ID: <CAE8KmOz-gbY5+6hRBPFmQn_MALdoQuigeoBS5+5deyCvgAosGw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 11 Mar 2026 at 18:47, Sergei Heifetz <heifetz@yandex-team.com> wrote:
> Reorder the code so the assertion of mis->from_src_file occurs before
> the call to migration_ioc_unregister_yank_from_file, which dereferences
> it in qemu_file_get_ioc.
>
> Fixes: 39675ffffb3394 ("migration: Move the yank unregister of channel_close out")
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  migration/savevm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 3dc812a7bbb..930a3391e35 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2885,13 +2885,14 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>
>      assert(migrate_postcopy_ram());
>
> +    assert(mis->from_src_file);
> +
>      /*
>       * Unregister yank with either from/to src would work, since ioc behind it
>       * is the same
>       */
>      migration_ioc_unregister_yank_from_file(mis->from_src_file);
>
> -    assert(mis->from_src_file);
>      qemu_file_shutdown(mis->from_src_file);
>      qemu_fclose(mis->from_src_file);
>      mis->from_src_file = NULL;

*  Change looks okay. But is it really possible that we reach the
Postcopy pause step with mis->from/to_src_file = NULL?
    Maybe we could move the following 'assert(mis->to_src_file);' to
the top too? Make it fail early before any call(s) further.
===
diff --git a/migration/savevm.c b/migration/savevm.c
index 197c89e0e6..18264feaac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2874,6 +2874,8 @@ static bool
postcopy_pause_incoming(MigrationIncomingState *mis)
     trace_postcopy_pause_incoming();

     assert(migrate_postcopy_ram());
+    assert(mis->from_src_file);
+    assert(mis->to_src_file);

     /*
      * Unregister yank with either from/to src would work, since ioc behind it
@@ -2881,12 +2883,10 @@ static bool
postcopy_pause_incoming(MigrationIncomingState *mis)
      */
     migration_ioc_unregister_yank_from_file(mis->from_src_file);

-    assert(mis->from_src_file);
     qemu_file_shutdown(mis->from_src_file);
     qemu_fclose(mis->from_src_file);
     mis->from_src_file = NULL;

-    assert(mis->to_src_file);
     qemu_file_shutdown(mis->to_src_file);
     qemu_mutex_lock(&mis->rp_mutex);
     qemu_fclose(mis->to_src_file);
===

Thank you.
---
  - Prasad


