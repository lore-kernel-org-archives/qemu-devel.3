Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D67C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2lf-0002Ux-KP; Thu, 20 Aug 2026 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lX-0002F3-TQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lV-0003Zz-Mt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkZztjaT0TmjXM0fRUtFSa+K+uc0EfXmkDvCsSGpsQw=;
 b=d3bpglIkq+hl67oxeO0nOOPpK+czUI/fx1xFpH79Z2wPFcPJV/9iWdTfoo6j8RchHWewxH
 EKGBHiAvXm3zYXZBBxivVDpzO4TBEqISXEafzyDHI2lufJ47+bSgqYkNm8H6UWaMufO2Qo
 mQH915l9BBqjhFhvft2qBuRsUQZC84A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-APsPl1LvMTyNsSaFreatUg-1; Thu,
 20 Aug 2026 09:24:51 -0400
X-MC-Unique: APsPl1LvMTyNsSaFreatUg-1
X-Mimecast-MFC-AGG-ID: APsPl1LvMTyNsSaFreatUg_1787232286
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C98B9195605E; Thu, 20 Aug 2026 13:24:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBCC43002D26; Thu, 20 Aug 2026 13:24:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 10/13] target/riscv: Constify CPURISCVState for
 various cpu_*() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
In-Reply-To: <20260820104730.25462-11-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-11-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213512.2730041.17815454845365274121.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=433;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OwhSCjayvPIfggZT9HkiNmuv1VtyqamRYVaUVXLaakY=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqG/+uhvSwlSmj0h1nl2tZLLmtnz0mfMQHSE7d4859igUscf
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqhv/rAAoJENro4Ql1lpzl9QQP/0wQ
 ymNTGNSTWkGjvKPsLk/Tcx1EI5kK/Bpy4O0O54iiqVEdGemOA0RIDESgpQ+mv+/f33Luj3wi2ED
 P8nh2ZDWSzisLeaqAWnRNy/K2M9gWt6mmKWFT2KXyq1XyOSJ8CokJ5srWMgEhd25DFoZgdqAbah
 ePcQK8mBypIarVME3qLYU/lhZTb2XrbLTZMk6cL/W7shJvneqdp+xuMqeuuEUJlspDLRxtowLr0
 KQXHWWuXM4Zb/q3aM1JrEUOYg/F0rdUAh5nRYA6bCuk7NcqnavW/Tx+V5lHy5W27qz3qWkMeCKS
 FHVOVh7YD1hzH5ckulfZ0qDeHY5YhYSsOyw8qD1S3bYa5b4keYHahMwXOX1k7Voj0bhaFyIOa2r
 O4w+tjtBIW+jn3l1Ie8JM7Hx36okOvD2FYZPsdK8fhFJ4L1DyEdRRdHMC1XO7jmSZVGViknwZn2
 TW8JaN1kB7sC8P/VJzHlYlerGm1wz7n0a5rdGXq0G0Lw2OeYBYGyU/aDdD6RUZuGuhpBNl83b1K
 WeBhvT9z5yZ9zCBBoTSg7zCtyYf1NruKBL4wjvO7yyzGZWO52Zx6Z+DT17IpnOJGhuLsxLg2szp
 /0fRdM5Hw+zH/gYU/Jg7/Yf1yad5fyUSzAEr6ZQqscnefaoXxCspgIpzQUKjSY/lol2VmSRUO4d
 +DctM
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 20 Aug 2026 12:47:26 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Add the const qualifier to CPURISCVState when the
> argument is accessed without modification.
> 
> Note we have to use the recently introduced
> env_archcpu_const() helper in riscv_cpu_cfg().
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


