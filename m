Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A6CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEp8-00006R-8m; Thu, 01 Oct 2026 07:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEp7-0008W0-DI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEp6-0006Oi-0u
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39dpLksEInDATZRUVwgamD9SQLAyIjsdZ4Ck9zpi4NI=;
 b=DV0/g2DFsbsf+x6OX3JtEsldLDPPbOx8zWAHDSZQs7r4CwNRl17veBoBneXsVmxwHgsnzd
 6rOgQkIP/COuujit1/TaYjn3JsGPb3Axv16ZTj8x6vc3jiised5q2rtyZDy6+J+mem/qIl
 NOs9hGjQhtQKGXa8JqpZL64Teds9rRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-86cDJE9HMXaqZrNTHoxvTg-1; Thu,
 01 Oct 2026 07:19:31 -0400
X-MC-Unique: 86cDJE9HMXaqZrNTHoxvTg-1
X-Mimecast-MFC-AGG-ID: 86cDJE9HMXaqZrNTHoxvTg_1790853568
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 644EA1955D72; Thu,  1 Oct 2026 11:19:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20C171956095; Thu,  1 Oct 2026 11:19:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 08/13] tests/functional: split aarch64 tuxrun into tcg
 and kvm run
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>, 
 qemu-arm@nongnu.org
In-Reply-To: <20260930164649.433573-9-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-9-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353199.2170790.6776923755107661194.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=387;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XU343DbtMeRmFKBKLGxndFcAdmsQXN+nRbozu+s+Kiw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGe2lrGpzbobfd6vUf2h0RjfzFFPBRXzpCfx
 aOEP27/7gSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5Zy9EAC1sKXovl2TFHAqoAouPGz6OdRClH0JCYC/hNWRWXrXQSrTa3XgRODbeCNITOzaa2lAH3d
 5F0VTzLtj2DSLud9evYgfOaeZFR6IfD43v3mi5Rw+8USK56NFrqOjAL4Z8P+HhrV79KYih1GHfg
 AGSyT/8SY73pa7tEYi93nAlGn1CQ/FrZG6MpLavUuf9rc6hsReA2Cj5I2qPFQVanR5D5pfvuWkp
 kK8W4JL4KzTGToaDB5UYmyRv0kG7gjsTEU91LFD4NrGBiIUxR2LrSLyDvz1LwLFZSymcEbvlwL1
 aYV66mvEhCQ1gF1ZUbAWzbwvA87cbCCFeWLahECtaAG2bRsDIK60INjNjMx6L1F/9tfNj7teMmk
 mwj4nQxBZ7IBlmqs4IQfif7i4jomqBCqdZ8SPZ3H4c1WBOb0hWKFZRka/J2tbZ+7KEiI+f1+wOq
 gUft7VeIVRji5hxjCREiL3HP8exbMfHA3N8sF/65uHGnyO7Febi93IiN0vxyobjI77Q5SPllZsh
 zCyPdGdsIq4g3deWvUreafX/OiY7b5p1IVDHr7xR7sBDZxWp+WzP3F2rP7sIcDVwox2/LEEOdEM
 OIND4CNCjrRPCjbunRkZBa38c9ytBIYdShjrEBsoQ/wU3ajnfgX/JpYHSf/EFYVpJE6Of9pXjrD
 KQFoFzYA0V6sjwg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

On Wed, 30 Sep 2026 17:46:44 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Add an explicit "kvm" run to the tuxrun tests. Although running on an
> aarch64 host would probably have defaulted to "kvm" anyway we want to
> exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


