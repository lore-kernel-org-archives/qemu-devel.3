Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5056E7491E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 07:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYJaP-0007H6-E9; Wed, 24 Dec 2025 02:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.6ik58odfjmyg2c5=adxiwfhpqivz=5l1eqztnweqs4j@em483429.getutm.app>)
 id 1vYJaN-0007Gm-Aw
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:47:07 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.6ik58odfjmyg2c5=adxiwfhpqivz=5l1eqztnweqs4j@em483429.getutm.app>)
 id 1vYJaL-0003eE-K6
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766563313; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=nIkx8hIkcYqz/T6jQ8Xv3kLyIpq6TNqvwwBv+o8WhQ8=; b=du4Vf0PbIJdXx0hq65f9e0kRJH
 R5bZjNeyRprWa0bGD8pcxyXQYlSoQ0rUxPV744/tX66WWjQ0AAdRb/CGw1mJLmm9p57xOwfvQNEzf
 iSnItMUeP73aTC+qBmQkiEiPEfcJzI+5FtBzP6Gpy2Tsc5mnHn2F6QqE+r+LtKyBexU+B46X7dy5K
 wrkKFo8JRHfV2d83q7tDDzL9OXaInBempV61SFG7nKKuEbToZYm6JLnBCaOdpGltrSWb+0+XG6dMR
 k/ffis1csKNcfB5DUE6kassz7LToBPHPK7sUitadfECDkkXNQWkCJolX2vDXJiCEFfSksymaRzbOt
 KL1q61nQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766562413; h=from : subject :
 to : message-id : date;
 bh=nIkx8hIkcYqz/T6jQ8Xv3kLyIpq6TNqvwwBv+o8WhQ8=;
 b=D/xz6WGSmPdLXapcgrVmw99ZkJ2VjNiXtVQmzOlkW0mgjEoj6XAh1s1cy5ZH/vJzCI4CE
 TqP3E+auY/zKYetBURHDRLnZ9H+dYuy3OSnWZrq9R72jfMIVeBfizJy8EBB99BzyvAhriDF
 chzv6mhBfemWMdFD6+6viOkEBDQ09S+VKM+sawkUht9JfDLrtmUcu8e4906djKQpVnKO7Hq
 lQNHhJOjfrK1Om8XPhkJuoV9O2/i0Wg8ZSaAwzXpjqngqBXq3fZf3ThLN+pKv8DjuL6DQY1
 kvIMcDzxVyflWEj/j5zeVylsQnvYr4khq295wcfs7Wwy/XtL9vW18Tw+nr6g==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vYJa7-pH9UWI-9Q
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 07:46:51 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f53.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vYJa5-AIkwcC8yGY5-7qER for qemu-devel@nongnu.org;
 Wed, 24 Dec 2025 07:46:50 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b79e7112398so968303866b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 23:46:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxl1tXqm2pC/rBRAPmm5YaO4UbgcLNNTs1vb2SjbgOz+iiwdzfYlAONm3iITs6EE47wTnpI9W84WbN@nongnu.org
X-Gm-Message-State: AOJu0YyEU5Kr/0nSpDzhhx7pCP6xEsrofBnR4ub9RCPcgzsKPOqepVCp
 BQs3U2yXSEm1PrRhX64dl1sxT2/BRXYoalBUfYJZYkKemvyWQE6aSw8kAASw5wSeiqHqF9RmW+p
 y6mMB+lAa9AxJUAsexYdwBHaUezln1vM=
X-Google-Smtp-Source: AGHT+IG08XwgOfRYTE75K1l6Y66RXVrS/UzXlzCDFQTxExS1gvm/gINM0p0nSXR9AvfgWiP7W7mwZh65Y7nB02FbCK0=
X-Received: by 2002:a17:907:7246:b0:b72:aaae:1b22 with SMTP id
 a640c23a62f3a-b8036ebd982mr1879045266b.12.1766562407397; Tue, 23 Dec 2025
 23:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20251223184023.1913-1-j@getutm.app>
 <247c13de-cae3-4855-bf08-0300d3633ae8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <247c13de-cae3-4855-bf08-0300d3633ae8@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 23 Dec 2025 23:46:36 -0800
X-Gmail-Original-Message-ID: <CA+E+eSAzdP4BfgvLhJAhuzMpXUX7PTcLHTZMNxdamVkvfinrUA@mail.gmail.com>
X-Gm-Features: AQt7F2rWuU7uInF8VIKTxnTgYBmfzZiYNHnn7CG2rt5vsBudq7XAYThNu_OpBy8
Message-ID: <CA+E+eSAzdP4BfgvLhJAhuzMpXUX7PTcLHTZMNxdamVkvfinrUA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu-virgl: correct parent for blob memory region
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 antonio.caggiano@collabora.com, bob.beckett@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: b55_9KpSVr1j.sV9NC2giZb9M.ABwTvgmtUWb
Feedback-ID: 483429m:483429abrvJvs:483429saOyvQou8w
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.6ik58odfjmyg2c5=adxiwfhpqivz=5l1eqztnweqs4j@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 23, 2025 at 9:32=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/24 3:40, Joelle van Dyne wrote:
> > When `owner` =3D=3D `mr`, `object_unparent` will crash:
> >
> > object_unparent(mr) ->
> > object_property_del_child(mr, mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > object_finalize(mr) ->
> > object_property_del_all(mr) ->
> > object_finalize_child_property(mr, name, mr) ->
> > object_unref(mr) ->
> > fail on g_assert(obj->ref > 0)
> >
> > However, passing a different `owner` to `memory_region_init` is not
> > enough. `memory_region_ref` has an optimization where it takes a ref
> > only on the owner. It specifically warns against calling unparent on
> > the memory region. So we initialize the memory region first and then
> > patch in the owner with itself.
>
> Patching outside system/memory.c can be fragile.
>
> I think an object is being a child of itself, which doesn't make sense.
> This can be avoided by passing NULL as name. The object will be an
> orphan so it will have to be freed with object_unref() instead of
> object_unparent().
I didn't want to break anything unintentionally and wanted to be safe
by making the change as close to the original logic as possible
(having introduced a UAF in v1 after making a one line change). Maybe
Antonio or Robert can give more insight on the intention of using self
as owner and if making it an orphan is acceptable?

>
> Regards,
> Akihiko Odaki

