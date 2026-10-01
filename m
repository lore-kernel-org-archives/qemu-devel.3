Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA3CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEpJ-0000On-I4; Thu, 01 Oct 2026 07:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpH-0000Id-2X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEpF-0006Pj-M5
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyZ/wdyg2vtK8G4yRDdp1d5By/tMXqWosBuV5Y8OgyM=;
 b=fwp4OA4OrSctT9lKz8HN6VpDobV9APmIEcu14xh38aiUHgwNJFdx0xb2abCpG2Cjs824pV
 l9jIRKO4kQaD0nvhgeWhqs20iEgAPHyd45zetGobHwiXbtzh5g5ZfDvN0nsK0hKDEQruy+
 TdCzoze8v+weT+hpvOyqXdaezKfwJzY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-C1x6Y-zsMpaIiIP5dbMwuw-1; Thu,
 01 Oct 2026 07:19:41 -0400
X-MC-Unique: C1x6Y-zsMpaIiIP5dbMwuw-1
X-Mimecast-MFC-AGG-ID: C1x6Y-zsMpaIiIP5dbMwuw_1790853579
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 487391936197; Thu,  1 Oct 2026 11:19:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48F9018002B6; Thu,  1 Oct 2026 11:19:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 11/13] tests/guest-debug: add --symbols option to run-test
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
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
In-Reply-To: <20260930164649.433573-12-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-12-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:52 +0400
Message-Id: <179085353205.2170790.9180581346521454847.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=345;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3ymq7kIrnmw4Czwt491MN+w7yYcD0bJ8j+SsxYbyJHA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGeHymqAPB2Qyj31ZuC+CFiWkwuquJP4j/LS
 3bnaw8ipRaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5SHLD/4oGyhqwkY4eR//mcVJQkj/RIgsnbsFW6zSka+NU7gLNxkfK2j+JVEdbB63kOoT67BKuqP
 rj4zpblBuvtUFhunBl2jHlbIJ/Quj/HmIyYnGRgDkY/LfV+nPG3KMLvlPLopkkrquKmnj4j8BZT
 fvqE+N6OcEIpFed0FCLrBXByR+Q9nteuzH2KAjEt1ToiDIGCRGLdyGl5R7yoCI7qC5wTIZ/4BJa
 6iXhth/O7fWk1bSBASo5a2BUWk5wqLsaBur3zUd5l0O/gmOuC3YK4pleSS8wFyP+RqMmCkTgat9
 RFliSGMaAUYcTaxCM1cHU9e0qbEKLZFTtGamD0VJ7AXcMbyqiXn+tAnYWLK4fFPR+oJcmlUGpkA
 CcNjwDsac1jbvqK/isTSQldMZIJkSDdAPDLhCIGxjLKcslNb8EUEsF+9qOwUn0TgvhbxKqNKHcs
 9Xnf+yYoYyCMFXVmciN5yD9TzFHjccG/b6Cj8aCKxcYvIYoMo5KWC9XiDsInMFLBRJrECagYTbw
 HD6RAwIzFCFlMZ2g1H3j/9IVJqK8Ah1kFfyD5Za5mFFwpydEF2SzV3pP+wafU3nxEjL76sDy0h/
 XM4SxYGNm8SIHcVMIaeNPRR+ixqiBxDfNT+r9hEgwAJJwR21tNi8mYSts2xVAujfyTMBaNqJ2Ux
 FTKj1MTC7jW6dbA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 30 Sep 2026 17:46:47 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Sometimes the debug symbols are not in the kernel binary image but in
> a separate elf blob. Provide --symbols to facilitate using them.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


