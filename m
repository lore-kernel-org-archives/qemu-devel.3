Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27BFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwItZ-0005zS-HC; Mon, 15 Apr 2024 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rwItX-0005vb-BH
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rwItV-0006XA-EW
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713174296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fZguhwIqTs1ZL2uGcRdmBzVDriXwvoFuOGWAFyfM4VeToFBpvPSbVpom0n5sFmFDbD4AT8
 qJsKpdyT218UwhxzsnYNT+9XVtr3cVm7Lc7xNMMtAXllOt+Yk30cjKOkX6GlD2mQZpvyT5
 2DkcUlSYT6JYn8vHs4eCcHY0q/NT3Hw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-kEwE5YbWNTG58f8L-X7jOg-1; Mon, 15 Apr 2024 05:44:54 -0400
X-MC-Unique: kEwE5YbWNTG58f8L-X7jOg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-417cf901ab4so11763275e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713174293; x=1713779093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ce5pJuNcby0XqG6RUw8eUKg92JVQMlY4jC8ebr0E1XXcSs+NcHKS5PAe8zG9wu0IXD
 HAslLQdS/oF+1L6v/wutEgAbXxngJ9dGzbH4F42Oq7c/xY7EBlzc8avMyRNp2qRAHT7k
 3WvdjW1uJwF36E8bdYB2b6J1A1m9xQN97wh9Ch80VuaChcseZeq9MfEBBAefH4yJuqdd
 7iRZwLsRaL/ZCaF+HLNQkNm7XXmqKc/Hh3Lg5Q1FaLQTKtNpUg4b55gG7P5SiFd4Sf/P
 Zl2NqAr5/lIvFj99EeE8XZKCINpXoQvSYSC3nLin31Melq6tOFFoz2FIgbnsYIwIlOcs
 D98g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUhLJp2lJXL1YH6usR5oY+yLklIv+u1UHYq8J6f3M3QNQdpHg4LrgBVXTG7lkzsuyxeHMshBtKZMypiCsF3VbOpIQ6K94=
X-Gm-Message-State: AOJu0YzLpTGh0EhxoLkjtJRrgqXfln58QQWNKqsKdXfZ7hY3xKM8Uxwr
 gxSJDZifrb2ug6JQoynWdPXDCqOqSAdZdaQPeVpaEPqhxF8GVD42TbiLtOyAbFHr2dkEigZf2q1
 IunNYOxi8eq81jsCs4Fbtu559xknut051SawWv7xTyYxCtENkiPk6
X-Received: by 2002:a05:600c:3d9b:b0:418:7c47:32c9 with SMTP id
 bi27-20020a05600c3d9b00b004187c4732c9mr214602wmb.29.1713174293498; 
 Mon, 15 Apr 2024 02:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqeEh0E8VAV3DfWUV9AaW77mYtke5mkqW0ym8ETAjIvkD5yYd7Gm+o6g7JFJWKOPU+SO5SBA==
X-Received: by 2002:a05:600c:3d9b:b0:418:7c47:32c9 with SMTP id
 bi27-20020a05600c3d9b00b004187c4732c9mr214588wmb.29.1713174293219; 
 Mon, 15 Apr 2024 02:44:53 -0700 (PDT)
Received: from avogadro.local ([151.49.82.91])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b004186c58a9b5sm2011058wmq.44.2024.04.15.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 02:44:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Date: Mon, 15 Apr 2024 11:44:50 +0200
Message-ID: <20240415094450.268675-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403145953.3082491-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


