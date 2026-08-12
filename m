Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9bT-0001aj-Ob; Wed, 12 Aug 2026 10:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bR-0001Xf-Ul
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9bQ-0003DK-L8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRL/ijJ+NdhPkfDoLbpEv3FGcCpg+nJBFin2kueEq9Q=;
 b=EeGDjtNCxMG3i2Qgt4BJHwS6uK40h3BOw9BO9D8gPOQS5UVhzoCRJI53YmKovBh8pYN6rm
 x2+0p0AiIhTbWA9BKHkRI5wEvPfAUpoBkjrhxU+GgkmC6p9fj1V8NcHvI+1EVIH8zlbpfm
 rr27e9Q5vwmjCzPYK28SY4mbpz9phJg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-gUf_Ct1EMf2C2X0valnNOg-1; Wed,
 12 Aug 2026 10:06:40 -0400
X-MC-Unique: gUf_Ct1EMf2C2X0valnNOg-1
X-Mimecast-MFC-AGG-ID: gUf_Ct1EMf2C2X0valnNOg_1786543598
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD4261954B05; Wed, 12 Aug 2026 14:06:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D77383001DAF; Wed, 12 Aug 2026 14:06:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 14/16] system: Move qmp_inject_nmi() to
 hw/core/machine-qmp-cmds.c
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260812131147.83188-15-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-15-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354344.2071945.12214784570643138719.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=398;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=U7UAuftl4OMfYXKpSNNIMlcZuELvXDtM8DCpdcQMBT4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH27Vp/P2hIibq9Ox9hlf9Hf97yFUj7GzCppp
 Q1iS0IySwuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9uwAKCRDa6OEJdZac
 5d1fD/4sh+nN5u0JrR910ixmvyq3+JVd/IQrYxVbEsd/+vyE0ZB97TE2/dYvMmCN2lrLLz6T8ZI
 ZFrBOBzwBFbkUZjlBWN8XLkXapjqCvwL8dpntS/55o3M7Wfj2iDF4MGZetgpT/lkFzHCRb+bCss
 HYMSzXhTsG5tgwk5/PgXpLTG1Uo2mNgaklKrj+myKHKIXSyw5gY2eIN/Z6wmmuFUXCTSrCFkC2Z
 RRBazHzSnGGXWhd6EJrLaxAVE7su/0zuglcj5aSl11VO6uXAZXfgcuMQp1PH7GYo30sNfR32Giy
 M5pYSa/py/nFQ37nzMR+uPFa3CXlKouBCaY6r8EtaCeE+vLnew/FQbmeIZtd0KAcdxEJus/mmoI
 0mqyWeJSl8pP0sHb4c1S4UM5NifYtNJIcgZUNQwEaa1ll8noQOCyLzbSDvXYmjaM+6p/C1kLSVu
 FyfjkCCzq6SahcSLB848fFmgNLJbb1yjkRfDdxmU5DuMXDsa2vs9+GOxWUI2H3yxvIRgE6SufkG
 BTkjDyiqmZcmVFwHnQW2k5SoDBKaA1yL1qW6GJ+BfMjdUNQIqemFWxD0J73K/bEhzLr6bH2SFPS
 /EFWeECFfyEtOV7S89iRXoh+iE6TYolHua6B250qNsgagGsz1E7t3PiAjziVcybg76fKvU93OZ2
 Ivczo1wVtY0vOJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:45 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> We figured NMI relates to machines (for their machine-specific
> handling), so move the 'inject-nmi' QMP handler with the rest
> of machine ones, in hw/core/machine-qmp-cmds.c.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


