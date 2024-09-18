Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9078ECCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 11:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqsou-0001j3-1L; Wed, 18 Sep 2024 07:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sqsoq-0001ho-4N
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:26:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sqsoo-0001Vs-5U
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:25:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so45624095e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726658756; x=1727263556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wL1x/D9kc/0DoSlj/2DjDcFgOEL3PIDCYA8sCBLYQrs=;
 b=vIEfDMrqxwfINKpm231Cu0Ho06Ss1tsn1czvBvX7Sj1bUgSPQMVBmmfhQMsgPft23X
 YmUvrvJ1i6EW89hhxYUaUAF9z8vkAtEIaEn8iUFlVLrtdhh+9dNgOKxB04RJylUBeKMb
 DR42NJd2NkDXOUt4RWcL4SEJkuh3Sm5YhvHD6ST6Rd+ImWozaXaEOvQLxk+HndO0cgZa
 LI8kRyL1F+ReXlSpfGyuEArcsatnKhkBnkAGfn3Xl0Jm2ccTbOIyOr9MclWCxywqxV1I
 sHcSCbWX+TGhMKsLiUee8mWwvwKg7CA4UZGWnPqXM8zl4Czof5dikqKOIROTs+/Ik5Mw
 aSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726658756; x=1727263556;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wL1x/D9kc/0DoSlj/2DjDcFgOEL3PIDCYA8sCBLYQrs=;
 b=ZikcrMdEustlxn4/rjQQqgtU6AQ3+n/E3RlWQ6/1RLzMQ0mbu71n5REE202n1RJxEc
 wUSc/PDn/AT0zFVGg1ObbNuyGOQerwgmNwVXGS6q5IECrK76HBWEm5D0B4Mn0zTc/Z+1
 Rvdd6mjnxzqgWuYG/tUTOURT6KaSqrQmEIV4HiKwuf051AdwnPQgRhbe+aL5ZRFe7ekN
 r2EyVUXfQe1Ekiwp39gqf2hleS8KEua7KASiZL+bdb8EwPQzdJCvY1u1fX3ZZA3rfG2W
 Y7+5mcz99MSJVXaHkB0WKGE8bItz55b8Zl9C6puXSa+043KCaJ40/LgUyobPXBY0wvlD
 PFCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwrbcKiituvBbZ8rutQKRZVT43J92SVQWUwRYzMrk5mGFVonYkUfSArlaBKve+B82haGnqSRwJOPfC@nongnu.org
X-Gm-Message-State: AOJu0YyP2N+zcKtEnscAA893FH74rfeao7Ub1kSKdkPhUl1yrsEx8u6Z
 OyDgX7OdPWpApyeJCpx0fn1gszBDeKpMYtIa3SFgpUNYi4UZ2VAVqVJrAk7bANg=
X-Google-Smtp-Source: AGHT+IGg5nJDaLrcAmCcfAp1Oybn+TIYtU70Jm1uhOi6buzcTaxtWraAWfmCPd+3klTonrkwjh7QLw==
X-Received: by 2002:a05:600c:46c9:b0:42c:b2fa:1c15 with SMTP id
 5b1f17b1804b1-42d90826fdamr131562875e9.15.1726658756061; 
 Wed, 18 Sep 2024 04:25:56 -0700 (PDT)
Received: from meli-email.org (adsl-13.37.6.161.tellas.gr. [37.6.161.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e70548ad2sm14361855e9.39.2024.09.18.04.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 04:25:55 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:23:50 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] audio/pw: Report more accurate error when connecting
 to PipeWire fails
User-Agent: meli 0.8.7
References: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
In-Reply-To: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
Message-ID: <k0af6.06n5wtgof6r5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 18 Sep 2024 11:17, Michal Privoznik <mprivozn@redhat.com> wrote:
>According to its man page [1], pw_context_connect() sets errno on
>failure:
>
>  Returns a Core on success or NULL with errno set on error.
>
>It may be handy to see errno when figuring out why PipeWire
>failed to connect. That leaves us with just one possible path to
>reach 'fail_error' label which is then moved to that path and
>also its error message is adjusted slightly.
>
>1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b
>
>Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>---
>
>v2 of:
>
>https://mail.gnu.org/archive/html/qemu-devel/2024-09/msg03485.html
>
>diff to v1:
>- Dropped duplicated S-o-b line
>- Fixed typo on error message (s/PipeWite/PipeWire/)
>
> audio/pwaudio.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/audio/pwaudio.c b/audio/pwaudio.c
>index 3b14e04fbb..8e13b58286 100644
>--- a/audio/pwaudio.c
>+++ b/audio/pwaudio.c
>@@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>     pw->core = pw_context_connect(pw->context, NULL, 0);
>     if (pw->core == NULL) {
>         pw_thread_loop_unlock(pw->thread_loop);
>-        goto fail_error;
>+        error_setg_errno(errp, errno, "Failed to connect to PipeWire instance");
>+        goto fail;
>     }
> 
>     if (pw_core_add_listener(pw->core, &pw->core_listener,
>                              &core_events, pw) < 0) {
>         pw_thread_loop_unlock(pw->thread_loop);
>-        goto fail_error;
>+        error_setg(errp, "Failed to add PipeWire listener");
>+        goto fail;
>     }
>     if (wait_resync(pw) < 0) {
>         pw_thread_loop_unlock(pw->thread_loop);
>@@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
> 
>     return g_steal_pointer(&pw);
> 
>-fail_error:
>-    error_setg(errp, "Failed to initialize PW context");
> fail:
>     if (pw->thread_loop) {
>         pw_thread_loop_stop(pw->thread_loop);
>-- 
>2.44.2
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

