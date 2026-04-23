Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C147FDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyuP-0006Gy-FR; Thu, 23 Apr 2026 14:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyuN-0006Gb-72
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyuK-0002w1-Tv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfc7KC6al/TR7anI/ymqosZUECJ8OBKkeIzRpVXx84U=;
 b=RaY7DOhNNFZZ/etDiXKFL0mQdvJxoGpVPMMypklg0WEA8g1iBXVTf3fgAXQz0M7fvBZXjV
 AoMc26j/Xj6O1BfCbGL/26RwrpsnBxtVQORkoupQ5s+8KGOuXCZ3pr2YyMlSIWvjY6p35T
 Qjy9mjEdZ9Wit1vjuHpAqsBzy5eAVeA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ExBI3r-BNk6y3Ms_IB_5Rg-1; Thu, 23 Apr 2026 14:36:08 -0400
X-MC-Unique: ExBI3r-BNk6y3Ms_IB_5Rg-1
X-Mimecast-MFC-AGG-ID: ExBI3r-BNk6y3Ms_IB_5Rg_1776969368
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eb9f8bbbb3so755478385a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969368; x=1777574168; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hfc7KC6al/TR7anI/ymqosZUECJ8OBKkeIzRpVXx84U=;
 b=T06yVL1bczgHZi2d2MWl9Y5ovfrQ5FHNqbHex93uVYBRAyixr46d4vwL/Qje4nchnM
 pyRPGyRWKR48R0N5mSnRjKeSVxsu3/pQAyjNim91NoB7oPb+jOV9DSxeW9lnhHcQXcq/
 Ow4xxnaBCbSj11AWOeEB79KZR5lsjVRJrOHyAoJRwNTteW3WTK2DY3fPyK6H2t/YBXuL
 0/AiopGm98teY3MHtsAi8lAD0JyQJcjtw49DElXanjx/E5Oz5SGLhjgwOLPdIGzzqZmT
 LpbTbJaiXQNfw+Ke5rg6h0gFLlKVolTU+K8LiW9yowATJCjOuH0V5VOsauco4IdCs3BQ
 ct+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969368; x=1777574168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfc7KC6al/TR7anI/ymqosZUECJ8OBKkeIzRpVXx84U=;
 b=RF7fEprUOh2zDyI9uZbXR2ziq9mElgWp8MYIJabw2b7YeoiVaGNipcfNii+pxSwM6z
 HdjpuHz5zeXX2GbPH90fq1FSNaTEcximqnuLhqUEX+WwLNA0tchpV3kPwH5fYgFtFqP3
 ALP3l9fiCHkD1CGo5nz6lKi39/Cn1+60xBzrmQriv5GlQNqoc0X3qkK6F8f7PRrG+c+v
 DA38BtmWoDlChAEhy8vSd67BZjinox5Ch58MTFx812BowV0SxRL0Ie2o+a3lc96rtvLm
 s/LBmpBqNwsSRDQUieVEP9kgJDVfvW74aLOxqUgGqh9PgXe+RmsvPEmq5kkwjVoaQ6t0
 BIDw==
X-Gm-Message-State: AOJu0YzB9hT0A/i7xg99alX373TMiHtURTbMjy8WwrEum/xl1UwOxXQv
 q/IpXbvpeWovB+K1RgJNL1G9uCvg2HTPWnwI3shYxaaq/NgIxFTVAjgjsNbVAOgmnPYYEgvezPc
 lwuc1ytKQPTm5DFp/2tHx3WNmzYbHb2ZPxqsZzNeMbO0t8the4BK+SbIG
X-Gm-Gg: AeBDies4GkCD3thVNeFmtHM2zicsRoO8ODMGTlKEwSOCWqcmQQBCfR6V9mewmuukc/J
 9i3rgkpzOkWB9GToiz3FD6JRd7n7PMmknnC3jqYufFVDMjku/Raq8P6dRuUbCSUv/LPl0tIbIYW
 bTNHJIn8v1xP4QqyMoSFxW4+02buRvjGZBDnlGcWrBLXaolLvHbzyw96vwv9wCeuBac54S/VX9H
 9TnR+j3gMo2Y9U0fZxje3SrpfB+EUyowtL858490gKDRxKkGBlQ4LBsUb9+gWlHRmW9tZ/cdoUo
 3yhqZLCHfyV4NupBqcrgKT9vy5GPJZK4jYAxU+GQT64mUyNNQz4y8dFRrpGj5NbThNkITCn8yPc
 VVYPRAYJyRp12ugDK7cCRlJbXiifYE3CzAoXbt7hmqcIFvRR/KXBTQHKmRQ==
X-Received: by 2002:a05:620a:936b:b0:8ed:6ac5:bac7 with SMTP id
 af79cd13be357-8ed6ac5c17fmr1420320085a.10.1776969367911; 
 Thu, 23 Apr 2026 11:36:07 -0700 (PDT)
X-Received: by 2002:a05:620a:936b:b0:8ed:6ac5:bac7 with SMTP id
 af79cd13be357-8ed6ac5c17fmr1420314985a.10.1776969367349; 
 Thu, 23 Apr 2026 11:36:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d92cde43sm1610962585a.33.2026.04.23.11.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:36:06 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:36:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhangckid@gmail.com, lizhijian@fujitsu.com,
 jasowang@redhat.com, arei.gonglei@huawei.com, zhenwei.pi@linux.dev,
 pbonzini@redhat.com, philmd@linaro.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com
Subject: Re: Several QOM objects crash on introspection
Message-ID: <aepmlLncre5BlpGM@x1.local>
References: <87a4uvw066.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4uvw066.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 22, 2026 at 04:16:01PM +0200, Markus Armbruster wrote:
> QMP command qom-list-properties crashes for the following object types:
> 
>     colo-compare [*]
>     cryptodev-backend-lkcf
>     memory-region-portio-list [*]
>     qemu-fixed-text-console
>     qemu-graphic-console
>     qio-net-listener [*]
>     x-remote-object

I sent three fixes over marked ones [*] above:

https://lore.kernel.org/r/20260423183212.468047-1-peterx@redhat.com

Thanks,

-- 
Peter Xu


