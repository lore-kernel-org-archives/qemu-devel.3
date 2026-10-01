Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18653CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEp3-0008LK-HQ; Thu, 01 Oct 2026 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEp1-0008Jn-7x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEoy-0006O5-Va
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vX8OH4SRaF3yAtGt/2NWoWSYSW24iHHeHUz7GWP3usc=;
 b=PqmzgqaqUKtxytXyBkOmmVEQeGqcTxVPeJl5SYLqMvBqXqlip/GZ70YJ4i7Klm5bnadvLu
 AyVLmftM9TE0P50L/l57HLeSHDeTidLUy+ZGwCEFggD4f0/7L/FbmhPP/Oft2WpyOhFXiS
 Dbx3jhtNa7uLVOFm7v3hdZqrJ/R48Sg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-brSrKfN7NLqas03Sm4I2xw-1; Thu,
 01 Oct 2026 07:19:23 -0400
X-MC-Unique: brSrKfN7NLqas03Sm4I2xw-1
X-Mimecast-MFC-AGG-ID: brSrKfN7NLqas03Sm4I2xw_1790853560
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7014C197906F; Thu,  1 Oct 2026 11:19:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B148418; Thu,  1 Oct 2026 11:19:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/13] tests/functional: allow tuxrun tests to be
 passed "accel"
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
In-Reply-To: <20260930164649.433573-7-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-7-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353196.2170790.10058789412177230415.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=983;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zz1CeTis/L4hwRCtTOt9H6q7rzANsm73gx7c2Oxsna8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGeUJxpcyh+vYsoLTvr7FetFIsRB7KsZC+Ex
 v8L6h7ErOKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BngAKCRDa6OEJdZac
 5X96EACRFUliwBVlZbEEJ2LhUh/BzgBt6O6gq16ia3C5CPcfYwGxnSkI7x93MQwx5Gw66ZJDqTg
 L6AD72izY8xmzJHDop9TLBBDjGnSsbKvGBH/ESxZdhNrrA3vVxQGfXEr82zMPbT7x7EzIpgKqY+
 iWqEvGpx4JllnC3bp1AIJCJj4u8SqGRZ33scD6NmxbEqCzQ1OCVnwWXkWIDj9wmpdLuILm1SCUv
 apl8HTH/9GohkrojkOQ/MzSoKfOgjVOTeUlsEK3NN+smgw8HH98ttlg4OLtVaujZsuWf/7sbzEE
 FZd+wvZiOCMMfrvJQyphM6sgan00vQ0CmEmODMTUK2ZvXzB9lQEo2d1gymwh3lk6g9MXDAl4D3b
 DPATJLJHRwIWwEE09l1axld+EVdo17yZvFHh/7NTWJzDdXwtzXGzXYxuss0aXYWAgmMEMIBkulf
 gOzxb7Fn3WAyT1jRPuGG0TODTKYL2u8Koc2UFaQj1v5KZKL3jBvA0KOJ77M9hj1ePK0Jx2AfCOc
 dXvkbtB+qI7E7AAc/1vHN7nCiAQAIcLvhrd/3clDFM43EgwiSVAvqTXcxjNBam5LLIjI7WIwDSN
 ktG/rULB1GcGTEYlUScwnQRdNKV6lm8QqtoPtnAalp96o9O1T6wqvG+N2+NjJISNXxzguxDdFYA
 hpqa90ZSFP2RWMg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

> For some tests we are about to add we want the flexibility to force
> "kvm" so give them that ability.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20260930164649.433573-7-alex.bennee@linaro.org>
>
> diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
> index 6c442ff0dc43..ca1589fea37d 100644
> --- a/tests/functional/qemu_test/tuxruntest.py
> +++ b/tests/functional/qemu_test/tuxruntest.py
> @@ -65,7 +65,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
>  
>          return (kernel_image, disk_image, dtb)
>  
> -    def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
> +    def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):

This breaks the direct caller in tests/functional/sh4/test_tuxrun.py
which passes kernel as the first positional argument.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


