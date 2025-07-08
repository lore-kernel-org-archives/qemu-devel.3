Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278BC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEe2-0007FY-B4; Tue, 08 Jul 2025 16:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDWq-0004jK-B8
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDWc-0001PM-OB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WOYwgB+uAXdUrpXQQMK8CMl8Pxz32sVOvu3brtwyoQ8XNhnP/NDi5N9teXd1tarecG8IYK
 Vt+mi2giSvAhRoiSaKw0smcdaZ00EN3u9rgBX0xgGkRxLXenQ8cYHQNIMjNNqyVqlHSOtb
 veT7Dt0IQjqOHZmTdb7IiiIQ9vNq1qc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-dLzzehAdOn6j8qdwmLC2DA-1; Tue, 08 Jul 2025 04:25:34 -0400
X-MC-Unique: dLzzehAdOn6j8qdwmLC2DA-1
X-Mimecast-MFC-AGG-ID: dLzzehAdOn6j8qdwmLC2DA_1751963133
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so21230645e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 01:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751963133; x=1752567933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=p+Rn+0iIMpS3QZy0fEtooYzJ3aeeE/h3tH1zu9Blokg9P/+Sb/ZUmgDMdCwp14AyWv
 zBdSxxLz0WRlmnKdvHMyK6n8DblAJ2RbIxs2/lSA42KZ3ermR3E5EJtR2+/FCXk/QWEd
 jJXn0x6iXRTLPrmC5zKjq3mo+Gi/S9Nxje/k/shPY2OSl1cT1+964yWLh8obqikbEvlW
 HVj917JX/hO5wAWXpR4+1SyR7QnTpR8tc+N1c5iOmBLa7pIVL/uhDVqxVo9ZZEA6P3Ij
 aXYVZBxOkdyMWk3Uzk1aPeLbBLALfQnQK5AqWmpIGk1uAKuClhoyHoLDX89U5Ytsvtah
 rJug==
X-Gm-Message-State: AOJu0YxhQ55nr1Lz9PNuOlXI16UrUy7QgBAe6KfQo7asXOzPIGGvIz77
 QYLxc0AoopBRpbOM8KMYD4OzkSxfVm//ELkWHDglxopugjnPKjHDJlsBPplb3g3/0YStC2txMni
 Z4tORDelqgr7zWDe8iKpRygacgBvYv+UA8w9hhgjJX57lUEVBHIdXswh92P2G2rKS
X-Gm-Gg: ASbGnctgMQThGW8iBrDWE4zBdFhOs01/ej/eMqpVj4xJrFqIn4XmmBq3eeP8xf0F2iq
 odG8o3Mt5o5JlgsgASpIzpSTXeS7QRAJDvgKhyNpFrPiXWHW4xMmsItb4sIfd6iZy7UeDIc8bYB
 jYcHrCc1wevRdPKCkd1xytELXMjDBApxUa/4ZXDpAi2ZI6UqpIdITDagdk0DJefkQqRAjHJXkJK
 AEC3CMCJJ4P08bDoxoFCPrwwVRgAfx0dH8K2rVOv0SO0ibAcgebGeaG1skxBvyCG8BnhCVmYL0M
 xYgXQ2f/7MKi5vqlBS28Cypg01c=
X-Received: by 2002:a05:600c:1da1:b0:442:e03b:58a9 with SMTP id
 5b1f17b1804b1-454cd50a87bmr16815485e9.25.1751963132972; 
 Tue, 08 Jul 2025 01:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/fcJF3fxMw3IP5Uovq/+WlU/pstWxinghusuEV6V/FHEQQ2MTZCnS03phJY5oeJwqma2MQ==
X-Received: by 2002:a05:600c:1da1:b0:442:e03b:58a9 with SMTP id
 5b1f17b1804b1-454cd50a87bmr16815195e9.25.1751963132570; 
 Tue, 08 Jul 2025 01:25:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4938ffsm14438075e9.21.2025.07.08.01.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 01:25:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] rust/qemu-api-macros: use syn::Error directly
Date: Tue,  8 Jul 2025 10:25:14 +0200
Message-ID: <20250708082514.49480-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703-rust._5Fmacros-v1-1-b99f82febbbf@linaro.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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

Queued, thanks.

Paolo


