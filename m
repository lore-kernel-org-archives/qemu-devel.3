Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23502C88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 08:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5ftN-000575-UR; Sun, 13 Sep 2026 04:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x5ftI-00056v-8z
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 04:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x5ftE-00079m-Sg
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 04:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789289321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieE/Mc103rnjbIvEpYdD+zlMVCdIF3XEmz/w0e4ChJg=;
 b=Pv9LGq0kC7j8iKb5WEWcDRFk1OqY9C0HqEZ6rd1eSfP/hTFnQTtu25mG2qiORU6v2ca+gG
 AdlO5DpbwRZheEBt3Ru1+2fHOfuJd+7BwHKJgNGFDJWXqhqYEJLLHpMlbOttys21uiTZly
 wm7WxxpfVNPBYG1l27SRf9HA5esZHuk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-_lGuArVJNm-IjA_zx4bmUA-1; Sun, 13 Sep 2026 04:48:39 -0400
X-MC-Unique: _lGuArVJNm-IjA_zx4bmUA-1
X-Mimecast-MFC-AGG-ID: _lGuArVJNm-IjA_zx4bmUA_1789289319
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so4090723a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 01:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789289318; cv=none;
 d=google.com; s=arc-20260327;
 b=IZidFqHxkjtLOGiEV8VjfkkU7d/KmQQLFQMbycqQ4JsgJ4eODfdGV9ECIxXD0llDkG
 SXEEBtQXkNv6p2S5YlkoBWf2gg/Re46Mt5AODKleIbTBrgU9iO1SL4cpjw0jkt+CsuDL
 /UukobGsITb3frLMRmBnSb6wesljLgfgU0CtUiTRpc7zHNVOd81AebdUv3oLktBoYIcQ
 rztcRxTw/CNjk8Tu2+i/1Wqf8LRby9Urk5LkCdOXfhH5eI4zP5tQWZW73d7iOiWLzdaL
 47RMS8cEd7KYZ6a+RlLj1kdwWFSYWol//emqRVZlNueYqsLInPnfQQ7LE1G73LK9W92M
 izgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ieE/Mc103rnjbIvEpYdD+zlMVCdIF3XEmz/w0e4ChJg=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=N0o2lvDPz9qBRGZroGx5LEskMm99kjA6FXP3Jgn6xUXGDPP5VWJD8a24ZiwHVeMLhk
 qA1IfNqoERLnEVXE3CkLaKVhuRU+mCm8XJMAz2b6klP2fslwRn/bDFlGRxM62n/WvGTC
 P61EDqVDoL3jWIDR4BgM4FPaRoBkvYbRvo0osxCjyq58PkNKOirXxv7+7o7289FF7xMF
 h8yPxvrlB08J8vm0quxX9W64JNxwIXpweKQ0y5sUuC7I1jC3qIGHByfLjbneSqEBt1C7
 /DK5X2LlwO0HXRr9FGVdOxgf+zSMG6Mh/7YV2YdlmE+XRRnfUVAW7viec+FUvfNW1/D2
 4cJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789289318; x=1789894118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ieE/Mc103rnjbIvEpYdD+zlMVCdIF3XEmz/w0e4ChJg=;
 b=Dp/5rAUg3xSDMGakRtOk5PPHeqsrbaTwNI+eSq71BUYqTtZMrT5bsLCRoISVDe9eUj
 THa2X0uHEJHoo/tPKDgmSh6Dm518FxqmD7kNIiDA7ntGpdXSZ8EWmg23g6oRBSFqI7Np
 U5GTYySC7yFjFqmy/gQpsOhO7N/IaTo654cd9MLoRAbBOEpltR5y4SGGNYDVJ+TQpMEn
 pGtWD7xpfxdKHF6o1WAu2UzEEmcHoIBKxkXXrpsjQXHBtUCM9FO+OXu8fqg4BGVYfDJF
 XIAu/FTWWJ57CuF65QvUkEnTMeN+uAN3HusG9PHra32YtlzTE+WEW0rGvco0FK27uEqu
 XPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789289318; x=1789894118;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ieE/Mc103rnjbIvEpYdD+zlMVCdIF3XEmz/w0e4ChJg=;
 b=drH67LPTtQy2NqkVwkeMeEIqudFDb0OL2ebGgi+uyxWHrHN7gDl22ZgXvqW31UyXke
 n/dRmcDyMuBKpO+z1IHTCq1CITnb6mYWdSH/GHTkK8RL0UZ5CeFjur6HtiwzRQCw3flu
 bmdZ4FcruTGoQixMruX0yRFuUMRjcUolp5u9nu7KzZun3uCoKARgBrp13sjFcUUUOGNt
 qiTbrV2OzXkMyEB1nV8SJdMwWLE+2qoCmAB/Cr/4EpaeXHAjAhxvELhHHAWutBNMZbx+
 b7uagUE9Bgn9bjPYk/IKO5MrpR6LAGkKacw2iFnktToYOizYFza7+x4XAdD2As/Cu/hy
 f0Dw==
X-Gm-Message-State: AFuF++mnI8ZAmAXSinmg/mGfvDmTXHOfFaMtn1q9wfkqFqli6h9BruKW
 ujPiMbGMp19PAicNYCslR7tTR8hjUI6wTnULty7LAu7dLLvVVIn0rQGRdpRnhkvmRUuCu3nGnzZ
 r2Cf6170IBpH2/ieMOhDUIM8/n2wC2YNMA4fcEuXPEYGiS1eXZcCI0kD0/BLfgbhFBGKBSi7FiP
 ruYV1csJedsx5OS/qY+Q01zJqtHdZqLdFqt92p4PiPiA==
X-Gm-Gg: AYBFou2RWtj+mBYfkaon+dxUPbDORdBJT35LCk2FiqcRuoFB7x/BnOjp12cwqpGi9RL
 G8jdUNbLRXuxLQlxgSCcT+DwXEQ7rm1VAt57eDulK0Av/wcT9jAnfFnQSCaLN0eSM0KdGJMWpgw
 l1Z4L1Iuvmuqyb/Pm8UuCwqjudFcbi8o3Ly/QbhYVd/yT9eLX30eKfFF3OFOhMEC6DpwAqvuyqs
 3uAeuLJcVl2UhQ6ZRRUz3lMfK+LhtApKFwTBr2BC2zMK7ADqSb8OmQiaif3kZuMy6+gKgeuUGLA
 /Q==
X-Received: by 2002:a17:90b:3c8a:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39dbbea2897mr10817216a91.2.1789289318538; 
 Sun, 13 Sep 2026 01:48:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8a:b0:398:e436:370 with SMTP id
 98e67ed59e1d1-39dbbea2897mr10817174a91.2.1789289317998; Sun, 13 Sep 2026
 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-flush-v1-1-229efa3f1e53@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260913-flush-v1-1-229efa3f1e53@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 12:48:24 +0400
X-Gm-Features: AcwNN1VMO7UZMGxaLAwLz9YbWpSV3YYKdScR2se0nJ9vM6EE3SYLunaPvr7A2Yk
Message-ID: <CAMxuvawb-ya4xMoehX4upa363EyYqKeRpQc+w5Au-6Zbx7cn8w@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Remove glFlush() after eglSwapBuffers()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 13, 2026 at 10:42=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> It is redundant since eglSwapBuffers() implicitly performs glFlush().
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index d595916476d9..0eec06826bdd 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -104,7 +104,6 @@ void gd_egl_draw(VirtualConsole *vc)
>                          surface_width(vc->gfx.ds),
>                          surface_height(vc->gfx.ds));
>
> -        glFlush();
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
>              gd_gl_wait_sync(vc, sync);
> @@ -122,8 +121,6 @@ void gd_egl_draw(VirtualConsole *vc)
>          gd_update_scale(vc, ww, wh,
>                          surface_width(vc->gfx.ds),
>                          surface_height(vc->gfx.ds));
> -
> -        glFlush();
>      }
>  }
>
>
> ---
> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> change-id: 20260913-flush-08715ed9f4f2
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


