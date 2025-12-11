Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4758D41C01
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbUV-00042n-2f; Thu, 11 Dec 2025 02:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTbUT-00041h-8N
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTbUQ-0005ON-QR
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765439609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OLgTWc1l1LcZ/aYPGs9fRi7es+LfAOF+6gA7Q5kqwalbqhY8xgBnLyA8ByS0JD3RwcFRCQ
 uPyGywmNejUEJtJFTmzvs2M2XODsCdeo4eaAysAxtqY7r0eEtr02Z4mYbzaEgWWD3KJZrd
 SMMqfgn5ijSI434mr8gsgGS+JjRCT/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ljRIExPHOIGH1GoSHe55EA-1; Thu, 11 Dec 2025 02:53:27 -0500
X-MC-Unique: ljRIExPHOIGH1GoSHe55EA-1
X-Mimecast-MFC-AGG-ID: ljRIExPHOIGH1GoSHe55EA_1765439606
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so4911535e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 23:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765439606; x=1766044406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=jBq+g2HRg5Y/gVm/4MNyUoNDur/sFTO45zRc1KJDZj3dmcc69aF4hhRWRliy5pK/Ue
 Lu0ifSkT85m4DZbNZVCMC+4nQGvmmUnc57S+3GPVPPKtJgRSVofdIWg6HVgS0Hj53Pc2
 glYYRkJbHVY3R8SwTC045UVnP2UY/boDqum3DHFA79OnTlgLzSjWf1XZFUsg/G+LBy6i
 hPEySzaMPZvRrj8ejpAcBbyO9+WwMBHk0w3m+D3AHzOAVxlyscju5DeylpPEqkIqUSVy
 ch3oZIdvXkWoNIyDZwWvJ8hOu0CrTA6YrHJ2MH96oZDyb/4PnCU6qSdetUQ5aQ4oNtzF
 qobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765439606; x=1766044406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nA6rAsJUyVDH3km+9rNFjmCTH20y068CQbIBTKXEbhIp0ydanfaVmyYmxy3YN2smJr
 e+987Kq6zIVCXBrOxmdLT9Y8IKMki3E44vXOuBvsBsbYE1tZzC49vA/ZGM0iQp7uddQG
 08lPepTYEUQMZqC5s/F8tjn/Oz6jWbKQMGw3FAL+pnJBu85xRo5Av7bB2A7tEW3b48SU
 XDRSp65r+IhFW1H1XmB4cIX3VBNI+YLvgkfzrqip+tW1weLX5DiTyKYb+NhsK1qe27Au
 JxWwPbttKRO0r9r+Ii9DiPCrE26P/aCK9VHKID9VmT6OQdyu7jYMqi8SIQ7/tN++J3/H
 Z7MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW04H9CnoQYK1NYNJm/1o7vSNp8igxcbBMEJqbIZhqBN8gx8s62O1hRduKRK/aVkBdSA5C+TMFJVxk2@nongnu.org
X-Gm-Message-State: AOJu0YzyNX8nqWWl0VoJmGXmUtkzCTzO+e5tzY1qGwriTfcVqZE94UJw
 XTorSzl2iLpuLXfoJBQmbYSAe7IKsRrzdkGoJCwNNxnGjTXKONeDlXZ6ru7T/QewdeuVMwVj9w7
 ILPJoy9pcfie9D2h73AGivX5BjEA0dWQi68R7tZ/YKU3qmiU1l2OFgYPH
X-Gm-Gg: AY/fxX5woeZZImyFpsgU12dE3bDrD1WvKwZL45d2pXOiDZ0srusE6oWFP6H6JBmyy2N
 0DgztMVw2obIToby6LxpFudWNbUy4dYoW0We4iO+Msbpar904Fp4slwojw2THux3rDC8I2V1Zs8
 3jJAxM6L4xPRfR3fDdAi0tLtmFW3rFA2227lR1Uf7iFqf1Vh1XEZBdJ8gCPvJR+vEaAweQadVCQ
 iZqONHzLOOgbOyDP8nNjxr1An+Ax+rNd9Ddfrs43y55Zag+oOxOc+Ybr1SraHH3fd/qpYruaTbg
 kyWeOtkjsuoRY0lDLdlgVQqaK3n5TNbEu2cw+LUK+y8lAe1tSY6aVno6yLL0vADst0mgOZcHoIz
 uid6qYKCJGFiWDHhdJa0w2pivLMSHJVyz/2XYKG+eCNpJU6svfH5jEMYQXade02CwEJadhibu2r
 Q5VLtcoSyUS8GzTd4=
X-Received: by 2002:a05:600c:468a:b0:475:da13:2568 with SMTP id
 5b1f17b1804b1-47a8384c5eamr53564325e9.25.1765439606454; 
 Wed, 10 Dec 2025 23:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3SCZC1mg+lEyjtVvHdI3Txv3IsKlN1EU0AqxFFKZz2+WHKw7ArWibsxM6ZbnPQDmK4qhWMQ==
X-Received: by 2002:a05:600c:468a:b0:475:da13:2568 with SMTP id
 5b1f17b1804b1-47a8384c5eamr53564035e9.25.1765439606027; 
 Wed, 10 Dec 2025 23:53:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66797sm4129011f8f.2.2025.12.10.23.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 23:53:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>, Xin Li <xin@zytor.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v5 00/22] i386: Support CET for KVM
Date: Thu, 11 Dec 2025 08:53:21 +0100
Message-ID: <20251211075321.1029031-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211060801.3600039-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


