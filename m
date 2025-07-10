Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B1C83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 07:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZm4L-0006LJ-Ha; Thu, 10 Jul 2025 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZm4G-0006I6-Mq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZm4D-0001Ae-Cq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752133898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QkF9ySTafepGFyvllvMwnjQTGN2+iKKQKkntau3O4g/Jryqh+Y+IC8qEqkY5FbHzp455PS
 SOWSJDlaJS2voMKDhV7uaNrBumyo9O1E4vMBvwOC31Rti1zZtYifkYOOUJEnuIz3+hZIR/
 RpAdSJmLdtmhevXoLaDUKhexX0WyISU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Pbs8stXDOUqF_Ri2PZLfFw-1; Thu, 10 Jul 2025 03:51:36 -0400
X-MC-Unique: Pbs8stXDOUqF_Ri2PZLfFw-1
X-Mimecast-MFC-AGG-ID: Pbs8stXDOUqF_Ri2PZLfFw_1752133896
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4530c186394so1983275e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 00:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752133896; x=1752738696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Q2f8kSuYRL3OtltNBqyQuhP00iyFFWINuog7Ab+Kqe2SvN5npDO86B+wYFmDC7F22l
 vhL/+wkX6PPSexG2/gns/4JDwB7qWiXy7Gybyg/ilBZ/uSqv1zAkTcHl5pK6Seab0yUu
 +ZX38EdJwRmwQL6tEmrT1uRV7OVJ7caNo2NperJvxNaancRB3Xia+MlsuB4c78qFaZL+
 8JvmEifxzlZv/MVbpvgl6IeuGj1vmrdyU/ApCRuOXVDOv9gLRcF3DA+kRE0EVi6VSqTe
 Dn5btrT1a/WL4oDVJMe4FetEi1aEM1dHqugB4DCw7oIXLbM4xzSjg3muBlf+I2C4uklY
 7xpw==
X-Gm-Message-State: AOJu0YzmZKK+Nq6nmNt30poq/c1QUIKCzil62C1ug/0XjX2BcKZQd+Ur
 qR1LFr+NZwGjiw0hJbiILOEOQLO5DVRQ8ZFJZS1yKf8Y6tY9yQbzCe17SyxXlGyssjl4MRTjZgQ
 IXKBeFMdQraG87Bkeb5OLaoCaztDXdDlFfQ6CSIuXN9wJy+p6zJZdq1nW
X-Gm-Gg: ASbGncviP/9SFQo9W0+PHffLmpJagVVNO2LLeUqtO3Q4CqO06LfzPuprBaPn08QaSQ1
 vCvAgz/UqcmnCsUhgjZ/XaYaCkmNUyeRl2RGjKYqi+8KQNRFIOc6H/uOKkJg5vs1YQkLyuTxqwI
 /ldqbde49I3GFsmXcDhUKGYkpZeRqjHr15yABXgP6Wh3J2WMXNUBRnTj+27UFegYX27ELfad47w
 Q2hkKaog8xiefcbY7Jps668HEWdX+MCh74OOyXT4E2E3VELnZFUF3OKJ6N1zuRehn9niZUIUuj0
 cKW0eas7X1pcUUQKMLfeJQ2h68U=
X-Received: by 2002:a05:600c:b85:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-454dd2f37c5mr13537035e9.27.1752133895641; 
 Thu, 10 Jul 2025 00:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXI20f5UifyWYQG9dLD8SwcnEdFIZXpqWQxsQ5vtxe8nQSxX9uMIaF6Rgo1IVO7Yq3z36ZLQ==
X-Received: by 2002:a05:600c:b85:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-454dd2f37c5mr13536775e9.27.1752133895210; 
 Thu, 10 Jul 2025 00:51:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d571sm1130773f8f.57.2025.07.10.00.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 00:51:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, xiaoyao.li@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH] i386/tdx: Fix the report of gpa in QAPI
Date: Thu, 10 Jul 2025 09:51:32 +0200
Message-ID: <20250710075132.227233-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710035538.303136-1-zhenzhong.duan@intel.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


