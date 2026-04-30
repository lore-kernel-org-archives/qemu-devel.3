Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB040FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINN1-0002sr-Cb; Thu, 30 Apr 2026 05:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINMn-0002Zm-Ju
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINMm-0003Fq-Cj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777540047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=UHBx6ETDcK0OmJ9hoDPKa+BYgA8OjhJ90dzAHFTtZ0F2c+jZBd7/pCdnSO2l5sPyygv44V
 qo1f1uck7NT4U2Mpc21hTOlJk+baqYM7M8RsjMLO6n+fmTAVTFq01MDuiXxeHzbT1FJLmU
 bZxdZHbFHLx5v6U+qDq3M4gVell576g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-8JSm_w9PNjWYtJ42t7NIlg-1; Thu, 30 Apr 2026 05:07:26 -0400
X-MC-Unique: 8JSm_w9PNjWYtJ42t7NIlg-1
X-Mimecast-MFC-AGG-ID: 8JSm_w9PNjWYtJ42t7NIlg_1777540045
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c2a4e257so4715955e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777540045; x=1778144845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=hCh9bOFTpmv8xXAxEyGQyUwxI73MlcD+2z7eQ8VycAxD7f5mTJIzLH6Oef7whwBG7U
 R2EXlDKxwgu07Myh+ZNdMdQ2NQ/nGmf9aqq6BP2GOfdFGj0MRwLMfzhAcHu737DUeCE9
 Yvx8HEa11rFvWmeoWGCiGSNb07IViTkfi0kgvxuyM1DcKOM0vqRgWDTL7uaD84Abck2/
 jnBy6ODWkzZSpNrk4nqy6TVKRFkCocitDUZiXtjVftaGBk4fn3hsts9K+RhxLSIptaAU
 C5OyXi5iVBXncjnObz8a5uXSsUD3celOY/GrwYtoDm4TfR5WlyQSsrIZu+ctFAt/YxbK
 ktKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540045; x=1778144845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=H7MMdIVmthyCpUOSDBdhmIVSxX82sh9IGKwvP3DBT97315B4yGH74z/p7ZQ5I76Jf4
 hYCIvZeizEmoUHLw7U1CjnkWT1YzP4bVv8qUNVr01znvgot1WZEJ3IyVSJHioZCG2/oB
 Gbccwbysu+ObPAXJyf6sZwFVgjBEFfXf5KHq2qxFW9/rpFeKT75z7QfWW5J2jrqJopkQ
 5Mw2/wQ7W/jWkpHayV6vROzNatbYkC06a51PdTaZfVvghZfBV4Pu90HtrMh9Jv8T4Jcy
 hJ6/8YBBvyC90KrzhYxgeSjQYRSNMvLxX1DAazu11B8NOEXAWmRvwXk6MxqdbxlN4Rhl
 9CCw==
X-Gm-Message-State: AOJu0YyjyUGGRiVrToK/H1wupxSNKEHpW/x1ofsQnS8qpsJNwcbP7J6/
 sZc2eyaj/mJzG0iNkxpDnHSrKzWICys9AktToVZdtknaY32R/InoXRAMYhIsRets7++UX1ithn5
 J13AZE4ripo9gcKbRSPcF3Q7SeeHT+QWEnjMbhKol6TZBlOJPxTUl3Thy
X-Gm-Gg: AeBDievYgk8vjTOByxf2+pYx5o3W6mEGNu05zhgg9hWCMdHGEypxL5xIAiA3dpurrgM
 0KsinjZ7aZQujYghqW0pbZW/+hneRWy687e56nWILD2Ii2qst1bFwMvH18ZDR0HOD4sBrihJbm6
 p+HfP/tkamS8myVXx87twJIld8hszPnqKMyVInQ/wXdTdI0QZwO9Qf9tFvAtt+gnXusdYY9Np8a
 Me7lOft7ZIXcx+Q2p3CWpnYs7ErKoaHmmK67olqvh0wCOk02yTHJ00eSX8/EFwgWIZUA0AM+LLd
 xsEG/Ze2+F4pgm+bH0USgq5Thndwnvf4ssV/Uz7x94EcEhfs827usGWIg6HqH12BJ/zv2EW0CxC
 ZPBKv60FWL/B3kdsjkOuei+D+kZRoquRw0Hz9HcUB6n637TBJgN35rg8yUV+0VC3JqUWuLKk2RI
 ZNIx5oE8MjfQGVRei5kUtL27TgKqrm5bHVBJ8=
X-Received: by 2002:a05:600c:8599:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a83d6c22fmr22925965e9.8.1777540044706; 
 Thu, 30 Apr 2026 02:07:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8599:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a83d6c22fmr22925465e9.8.1777540044187; 
 Thu, 30 Apr 2026 02:07:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm53197455e9.12.2026.04.30.02.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:07:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com, mst@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 0/3] hw/qdev: Consolidate qdev_get_human_name() and
 qdev_get_printable_name()
Date: Thu, 30 Apr 2026 11:07:22 +0200
Message-ID: <20260430090722.843067-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260321100405.1525059-1-alessandro@0x65c.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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


