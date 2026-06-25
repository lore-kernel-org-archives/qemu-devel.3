Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FFCCDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcr7I-00053G-5X; Thu, 25 Jun 2026 16:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcr7G-00052q-9u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcr7E-0005vR-NQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782420963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=hA+PKWb3JdyH2eftj43Y4GAFyHMIMZzt0NkJpOfRKmJJe/LZKd5aokqm2iWTlpPUSZjoXo
 Eh4rZrmMuOhcaHEabPDDRJeVpl7tVWOyzE+De67paKBfKE1NVSYWE+iLN2grmpwKGA6ojI
 pCKJ51H4MaODqa+M1ydK1jBat2vo+YU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-njjvjg-_NTyAVSPU-PXRtQ-1; Thu, 25 Jun 2026 16:56:00 -0400
X-MC-Unique: njjvjg-_NTyAVSPU-PXRtQ-1
X-Mimecast-MFC-AGG-ID: njjvjg-_NTyAVSPU-PXRtQ_1782420959
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46edff99956so28651f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782420959; x=1783025759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=m6HuI3E6yIyT7iztZRc3zyR1nM+QPvjHJPTDnDqsaoyrc/deU0tSib2Z2lE/0PTTzh
 qlttklnIgykn4Ory7lQeRkNlbaqqn1HrqBhc+INi3v5SN9u+Tlb6lP5J7YC8noyNz0kh
 Bli4/xD2dXH5QCv0Xk2WFQUeBqko10pLPL9pRckpWKCj2tffHqkJra8HfbbiwBWTW2tD
 MTQYpsQ1P8xLlMjeUGsZG/g9F5Al2CnodsIMdoqusR5qtGWoDuKmOBPGlmTLeAqVF4/2
 dZSaCwKs0H2hM9CuH8fOVz65PYfDFLvB5AbyCD1FNVc8eN8EBIVFyHEANsXD2q7UlrlF
 VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420959; x=1783025759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nZBCGJ6adS2u2O6qs973hvjpQ71fNIJ19dejRyPH37uMHkfPLw6CvfypzAi1LfKAdk
 hlGTGn2HGBnksCSUY2qF1LUWU63XA7q2RgJdYtGtM4Eo1o5AzyNGA8Cc9jDhHfwJO+B8
 bTVpFTOf9mCLIaGZ6pNA5xZE+3ocVJHIwPFwbwH7RMDcKygeYARqGtDYwhc4CQlWAflq
 Ew3OENJfvNnaUqQWZUbQIE9Eu02GngSJKg2dJ4xPNnE+DGHY/P6g9ke0gZwHwV7IIgEP
 XNM1cItUeWMDHaHtVD3C632IQk0YXZW+gGkEp6oKxljuUaHmd+MMqx0RZaVNugf+Rl3f
 K/mQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSIVszoxxPH3Y43yddyi4lS+7QXGhJjOwhwRjkA6xRvUo2xhCR55/r7+pXrfQgH/8bP3iig9CLgTy3@nongnu.org
X-Gm-Message-State: AOJu0Yx2DSEZ6xn2CP60rtfy3ci81t9PGmu5YQCIWPOuE/jcovJXBPZx
 ysQj0ImRs+r5F0HXfHwEnWfobhS8JTyyuU39AxuoXL20O8WdU7fVd4FvZc6Dz46+kZJlMyEx9b+
 LpFf/b79WN3RWM1qofOhEgCqAvQKP9EVmcpdzVFCDRVYBCAWp9O5F1AHp
X-Gm-Gg: AfdE7cniVXL6u4sliARcu6wbJCcpPbQHBhvdmCZNO+fJKjq6Qib6XI9nzrd3lGbfC3W
 RiIoEzh70wknhbv6zApPww5IcW9id8jIjpCou5jcynKvc197K6MrHdaLYZ/u8tO42KtW1+xgeto
 77mvdJ1CyzT9PiVpuKjEBN8BzEHElzwW/CLL7Q4CI7mBvqUc7n9rZXf0I9FujoUvXJMgB2ZwdpI
 9VC9KEG6K5Xlc4juZiq/+szHpX3G0oXQb992791ddVQKV7Chnzk1H24RybwccKR8xFsZI0pGmYY
 3cdR4ZfzeA+tz25KAwn2+pwaTpQX3+BPs5Ym695lR7mYXs7Oln8zUmc+PD6OHkp9rlmiCQM0Clb
 eHYnbVpiEFi3K36qhAmpcubdx6+EsoMRZ8PQbUry8aXyZLHbjLvw6IWodZsXdcRhhPhjWywbsye
 QLYSdQ8HvSLse5i4g9
X-Received: by 2002:adf:e013:0:20b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-46dd69388f3mr4621984f8f.46.1782420958873; 
 Thu, 25 Jun 2026 13:55:58 -0700 (PDT)
X-Received: by 2002:adf:e013:0:20b0:46d:d693:88cb with SMTP id
 ffacd0b85a97d-46dd69388f3mr4621973f8f.46.1782420958590; 
 Thu, 25 Jun 2026 13:55:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46caad603b3sm17100294f8f.7.2026.06.25.13.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:55:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/5] qemu-options cleanup and deprecate
 memory-encryption
Date: Thu, 25 Jun 2026 22:55:56 +0200
Message-ID: <20260625205556.1676290-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


