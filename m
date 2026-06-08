Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0F0CD8C8E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWTCe-0003hk-VS; Mon, 08 Jun 2026 02:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWTCc-0003hH-WC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:11:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wWTCZ-0001hI-NJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 02:11:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490c1915793so22351945e9.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 23:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780899070; cv=none;
 d=google.com; s=arc-20240605;
 b=EpSCmS0hXFt3WCthhoOGwQCKXuw8/HaWonkS2BuXJePGqRyJ/JYSbGP6HJ0ntogVdX
 MfQ5ry3lLY9vTfXYzd274uHrHbe4on+h8iE8Tl/7JnENZ5DLXSBmoFW5JsQd7CVedU5c
 SrxfaHCFodaQVjtcwSWS/eBQZXHejn6hu8xjugWraPJ77E4fyCRbqJXj1BSLXnvabZ2v
 9ExqiJUDrgKhcgVaUyJA+LKlQGP4mVwLHawDdp/MKSkRhrro1mZAdPXjz4uj82ZyriK+
 XmTw10mED8ZuXyfe4FsSJbo+pDIFssiWRjIj0IK099JhM60wi3HEO6ubgRQPgYsbOSW4
 DL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1a8eSmWCgQmzMF3KwuK/8Kj9wC0sXDaZJLfTaTYI6B8=;
 fh=YBFN6sLm21gmJxCSu10/1CqbRgX6DuaJxwQ6OELLRx4=;
 b=EFCli7zfnpqopE7KdNrcHugJ+ABabGE9ij1AHPH21Nl+2LI79kOWcWmguommypaaW4
 EnmtlDHvxvQY86ymG4TEsrofQhHHuCmROupFAR/POk9AH/CoOxmdOfaVxSVw1hJl8KOU
 XQUU9ZqDBROR9avQBdks3b3vkPurskUCruyn2rIRSObpsz3Kfcimfmh/Y38Xl1w/dLTa
 L+l2/8dv6gRLbHrC00ygmUEdl0hRJ2zqFtVw6AoX7/FtUNPFLUsAvRA+rUHOb1Y665Ha
 Svcb3/tVpeU833pQXGV5KmKanojj1ZvBcHTp2twTG4WI6h5oSPKSjbif0kOvYJQOa2ho
 sOoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780899070; x=1781503870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1a8eSmWCgQmzMF3KwuK/8Kj9wC0sXDaZJLfTaTYI6B8=;
 b=iaDe044Z1tmJaax5WM/92NIoyeKSyZnNFntdepaWiTo/oUkrJYGbPK5nh0F5VjvTAI
 VKyEGiD4zD7wbJjP46+FMfz4G33B/hJrB+5yKjqQHZYQbG2xREW62vKvNFTt9XnMk4Q6
 gsnoC/lVeGNGqjlEmwWEQURaxzbgpq3D22R1Fnw+COpszYtYrtzCFyPSyCHiU77J4YIh
 AMHWalW5PbqdCgdwV89h7V4CPNSYkLqE5Ko4BWK3Cm+uzOJ+MYVjROOAhSlNaHxYeInW
 dOqBdOeVQklrJ3zQyiptaUagLTu3bXZfiIraC+eGv6old4wSzQLIQLUhWAIX9TrRIj69
 PrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780899070; x=1781503870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1a8eSmWCgQmzMF3KwuK/8Kj9wC0sXDaZJLfTaTYI6B8=;
 b=LAsjV8z3CypstkS0VyY/KZSnzaapgsg1DbpEbFijRAAGFQSAefOGH6+MSkU/yazK5l
 enh3LvhfLVQk410gqcXQcFT1Ci1ge1daAJDnC3WEexr5X00G8IRP4wWgmZzfrzXcVdSz
 OKnY6TretUlvPsrwF1uDkMFii3k8LjCnNVSQ9Qof1Rqd3T9TYhcaf1LUpLKfougH8e4J
 LhW9UZXlx+GAVMmrBV+PKNib+HVXtM5he5Dm7YuLmbGhywAldFTfLB43F9bEcfy2HKxJ
 X6WBKSIwQWUDjpbhCblgBu+p8fbpNx8gqlIHneLs3Zq926N999WP7yloCGj3NtuHl9oL
 x6Yw==
X-Gm-Message-State: AOJu0Yy8JkopKS0LFmaCL2WQ4zTUK4mdzeokX8SZAerSJ2UwXGMzs/3s
 ObtB0vYzV6taymrjwi1wAbCWJrMA9H6j3cJ3xGmqqPlE2jGCvlQV6MA22abIkkkDoFonf5phLwF
 rzK5zdAUUyRk+8vPWl/6dMchvyfPUXZXcXdXbSPiD7g==
X-Gm-Gg: Acq92OF7qjQx9bHciEL25TJ0efrJ9pApWi3EdjmHKqPdcj1frYAk4Aj2j+4vBITv+rV
 96QMttpb4jv3DTooyIPSmaJ9IEhC48jDe/poDVN3VvOJCRwk3ggfa9bznXDgpk0NCs9uHFCG5l+
 kOkiXhg3ZDX+ecBfgVWB74MTVut8g3uiy1cWCjm2Ps2EfSTaQW8qtbhosntOORORXE36l1IlMKD
 eyiLmWLsfUL5Y/gE3U+LXe1JKsM5CH4kf1z+bBqwt/UQcvJ2rUDT2DtNeakOFuUc/lo4w1frlXw
 3Glx94rx7tiyYqcei/VgQtYWgxUkj+bikKREsBoZpAOPYO7SKyF6FVC1SoiL
X-Received: by 2002:a05:600c:8b6a:b0:490:bb19:b110 with SMTP id
 5b1f17b1804b1-490c26216ddmr213643395e9.27.1780899069728; Sun, 07 Jun 2026
 23:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-5-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-5-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 8 Jun 2026 09:10:42 +0300
X-Gm-Features: AVVi8Cciw5hT1f9yzO4tkF5vqeYsvJk4I87ifVcSsM1azmbSo6BzVovWKCLAxok
Message-ID: <CAAjaMXauAqh0UmrRy-X-p1cDjBP4UXM67dOin-=3dtYhE0hsAw@mail.gmail.com>
Subject: Re: [PATCH 04/25] plugins: remove type qemu_plugin_simple_cb_t
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 3, 2026 at 11:53=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> We removed all usage of this type, it can now be removed.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  include/plugins/qemu-plugin.h | 8 --------
>  include/qemu/plugin.h         | 1 -
>  2 files changed, 9 deletions(-)
>
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.=
h
> index 499441bde23..3c6f32bacfe 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -140,14 +140,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>                                             const qemu_info_t *info,
>                                             int argc, char **argv);
>
> -/**
> - * typedef qemu_plugin_simple_cb_t - simple callback
> - * @id: the unique qemu_plugin_id_t
> - *
> - * This callback passes no information aside from the unique @id.
> - */
> -typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
> -
>  /**
>   * typedef qemu_plugin_udata_cb_t - callback with user data
>   * @id: the unique qemu_plugin_id_t
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index ddd77bd82c9..dac08cdc60c 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -55,7 +55,6 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPlug=
inList *head);
>  int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
>
>  union qemu_plugin_cb_sig {
> -    qemu_plugin_simple_cb_t              simple;
>      qemu_plugin_udata_cb_t               udata;
>      qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
>      qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
> --
> 2.43.0
>
>

