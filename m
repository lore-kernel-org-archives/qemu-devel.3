Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F8CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEoo-0008IU-A4; Thu, 01 Oct 2026 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEom-0008Hy-HX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEok-0006Mu-9Q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttqap0xOgpwCf1MNj3ScDeR3kvZSDaIHJNJm2AqN+yo=;
 b=S4pwc6YBE6c/UbELapsVzhdCN73PKrb8AHBXM+5RTA3P7x/DqaiiA4y3FkdSWbm6DRj0sB
 NDeDRxP97w8Lg4zFaVduNpwGaTxI98KplvJ96AYgmgKaGioij7aTDH7IWDr3WXR0VLHZUF
 6o+NHCU/DAKqqSwLlCVfRvZzKVb1Z6o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-P62N8RfxOfusI-EzmulP9Q-1; Thu,
 01 Oct 2026 07:19:10 -0400
X-MC-Unique: P62N8RfxOfusI-EzmulP9Q-1
X-Mimecast-MFC-AGG-ID: P62N8RfxOfusI-EzmulP9Q_1790853547
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CE141955DC9; Thu,  1 Oct 2026 11:19:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD67F30000E4; Thu,  1 Oct 2026 11:19:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 03/13] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
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
 Max Filippov <jcmvbkbc@gmail.com>
In-Reply-To: <20260930164649.433573-4-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-4-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353194.2170790.11593114851916026251.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=560;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NBSVaOT83ohqmCEhAhGvgcN2RlvHZx1Kg6yugNu1b58=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGe3XA1dooFP3hzdciyWOEaLck5FxC33W4OM
 SlVkm4et42JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5QzRD/9LBSpUmVYNUfNYcR8f9FEi7BNK9F4IAXWmqCnlDajKpXo/SxM9TToKRZjOPBeiRmrQKES
 YWYtFqxeTqkzjlCccEhJXWX5OIAXACswfESIYEtWgRkugOiqiPWDDcsoMpPFyyIZlEEiKIqJDl3
 M5hnMl2hPy3ZUScD92nz7tec9mvOS4zRqG+Ipl0lG3dwOyyDcUWzJn40QpQX5RMsZcBu89I6B1k
 6966MafahS1zedizSQTWwbGFUJvzhBeAw9x5sakHqReK49iK2yRQrLpEXGClF3hT2nmMIdu2212
 MmVDcHIqSvfJLjqS5KXGz+3z+lohiQ7a3x46NnRktV9uMJ4ZeEa5gprlV2Z8WbRJtRSSrla4cIt
 jWlotUqpWRfXSW04kpEHbofTN9S72jZ87L5VVRMRGoJyDHiuEsMWQskqfvfAzfcT/kxOguMNxk+
 eOqfbDdYzJUnDrKckPrY3XQwOKDYINbLH5YzMLaH2+ngONDY9eOV91nrPzGlSfP87yBVUHuaDCT
 cDvSIFfP9OGlAcgeldEod9O06TESU2Lgb6Xs6NhsAkk0RzIEvl8CzhJ/PlURHcXo7v7cglthmls
 H5+qg1bC2J3Vq5gvbPaWmau17ZW3kHPcBdiV/aWEh9Iy4VTIrFxOg14tTZTfqtQdLNhLuK60fxh
 pYWqZX9wnL2loLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Wed, 30 Sep 2026 17:46:39 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
> 
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
> 
>   linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


