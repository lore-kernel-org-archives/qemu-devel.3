Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC4AC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5mc-0004yg-KF; Sun, 26 Jul 2026 16:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo5ma-0004xx-Ub
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo5mZ-0004wG-Ko
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRx8A7A/phIuHiTjk/0EnRV/DxmebmUEL531BmVt/oY=;
 b=LSjWUR2ieU6rIfkIyK1rK0OxgYZiC8hIT2MAfjsehOAqNaokMgFFrv4vcO++rueY4NqjeC
 7eK/2NFzW4+sqQsPO48Cuao5WOI4yn84xq+STXhbavMkuXmDshiJCcwyY0Hsjl5nvlQgua
 HGvk8xbHv2rrRJiFlKHzWLwmRkHBYN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-0VazD4QAOheqGCVnluDT8A-1; Sun, 26 Jul 2026 16:49:09 -0400
X-MC-Unique: 0VazD4QAOheqGCVnluDT8A-1
X-Mimecast-MFC-AGG-ID: 0VazD4QAOheqGCVnluDT8A_1785098948
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49544a639e9so10371745e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785098948; x=1785703748; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SRx8A7A/phIuHiTjk/0EnRV/DxmebmUEL531BmVt/oY=;
 b=bWFKpgX975nCzdChxX/JPAC3MNtHNlhlLaBE4Cj6yl8wkDEG2HjownCsMo7RghEF+0
 APyO1Rg6Rt27i/Ks1fUrWsS86YyIl8vMKu6Tky7pi++Q44z7p8GWqOxMNxwqHqPEuVY7
 Ur5NFA5ATTweYhOVwwZMsbj9tjuHv55vmQ6C7KDC3wknDf1V5tIv2+zEmK+3scekznzQ
 pWUQvSuQYrJGxRj5/LXxX7yHStS5cIbtF/Rz0V+AjNI8j99ciZ4bV8y53j7BUb2WYetK
 ajXJhR6HMHTDACk8xfl91xpbbM5BKuwGh4v6yiq36FcGtEr9gzVwKYUWzDmGTpOeovgW
 QcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785098948; x=1785703748;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SRx8A7A/phIuHiTjk/0EnRV/DxmebmUEL531BmVt/oY=;
 b=PlXcDkgu+RrbikXQ7yvpeta4ISPUebmEKRZGSALwnidmYrckWjvIue+DLSQIT5Ab3f
 m+1E0067iCiYiy9NM4knMvornmmJylKvIp7jI/vRwAMEM/k/71Bjo1fVJp9YjakrLuMF
 +a7WzdQKtThWpzqrFIoquYN/gbGbQzosZ8FVUVU3Ig3RRqEboT4jqlYwdnHqYHkqz2vq
 iG9RjclFGRG0xfPSf0evuoFUNlma+EcoCyayYpgkLbMau0+3hFRH/hlPke1zYRY7BYwa
 2rvvENglsqpcjUhlvMZyzSdZQYlp815li+T7oO00wKBuiB0+f+AlDXoNZMpKXxUsNPR4
 mB7w==
X-Gm-Message-State: AOJu0YxtM6cXjVXA1faihpCmg0JiZWqV1cSiOFFKQlehc0H8lwIa93SM
 TDjnzyCoy20I5wO/Re8IDBLGXI2I9tAJu421ZhI3JC2b/XO4hMNUnRV6ZOQtbVilu35POctiwgP
 FzxWfqR0WcT29SIgZRZRiMt2h88VG79Oxh0EMrp3Al0RS2KzdHaew+wJU
X-Gm-Gg: AR+sD119dfiT/PDKLpF0pLbPy+e+yjNwLuNorFAt1QqgqhgQfyAPR2ljmUMkQQZoqME
 tO1r3V0vchnpd4yDZWxnEdTyxs/rDAqIw5nYoBbqhImEvmamsowOJw5Ufjkr67A31nJyIivw6yn
 EKAn7T9K5DRO6bz+ZM4yo/tL1bg/C4aOCumsDytZW7c90IMIE4e+FVXvIalJozCVgY4VFZNcSOR
 ekxCFfBxzG/p+TG68JGIApkHmH7Jtu7LbBe/2B8yKbMbRHDQaIzSycpwc2aw0rXJaio9g4Y0SG7
 m4PZZAmhQvJhNeQjM2YtqEzDiohFBNt+toiUZrHFlAagSOTxPqwk/4JmMgP2RQ5WLr895iihDgq
 jJW8WxgyHejnjQ0J7B20Qow==
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id
 5b1f17b1804b1-496b5747d8dmr85138015e9.22.1785098947901; 
 Sun, 26 Jul 2026 13:49:07 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id
 5b1f17b1804b1-496b5747d8dmr85137625e9.22.1785098947423; 
 Sun, 26 Jul 2026 13:49:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b49a6e17sm161972635e9.13.2026.07.26.13.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 13:49:06 -0700 (PDT)
Date: Sun, 26 Jul 2026 16:49:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Message-ID: <20260726164738-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Not commit log really?

> ---
>  hw/cxl/cxl-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 7e744312f1d8..eba13c9e7cba 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>      MemoryRegion *mr = NULL;
>      uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>      MemoryRegion *direct_mr;
> -    g_autofree char *direct_mr_name;
> +    g_autofree char *direct_mr_name = NULL;
>      unsigned int idx = state->hdm_decoder_idx;
>  
>      if (ct3d->hostvmem) {
> 
> -- 
> 2.55.0


