Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F3FC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGzQ-0002fs-Q2; Fri, 11 Jul 2025 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaGyj-0001z0-HL
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaGyh-0005S1-2A
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752252721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GACvAVmfFKI+OkVZ4KjrsMIkTU7Iiau2SM0qD6/bJMO/QIkEhHql3mJ/XIz07Q0lkOXrtz
 RXPoa8g+Gg/g299cZnw0A4eRSOOL6i2tS1Z1ddnUx96EJK/PO+zz2CzXxyfhSkgBxXm/Zq
 CK0WG6RdTja5gLzuRro8gVLH2PsglBE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-PFfanjJwOuOUX4kxfe520g-1; Fri, 11 Jul 2025 12:52:00 -0400
X-MC-Unique: PFfanjJwOuOUX4kxfe520g-1
X-Mimecast-MFC-AGG-ID: PFfanjJwOuOUX4kxfe520g_1752252719
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso1513711f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752252719; x=1752857519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=emm8MFDCSOuEp6GFLlatdmnboT9TzfgeBhrqazhNOWhnULywZYY6Hk43rN0PDj7KM6
 diZr6J2x49KYnSEnU+qwmJs7KHGIKGLftj8HjXI09bK9Hqd4gq2uvhxbwzFErGvoOidX
 OGoN0I1tybXHH8O/Him9ORrYoDJd0P4J3WyYi+Y3I1zohJRKu9/dcnQTj4/flNVwo3cu
 wUWCzjCidsV2OkWgOPA1HrUgouxFvKOEg2KTdR+Gdcc18yNevzYtl2bngCwREIdGiY08
 /O6V4n/DcFBEe6iFarxrpcNHdsOUpPDZq0/yMkbSAsVLZPDtzMFUUAlLz+W8x5nTEWq4
 4qKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKsJa4tqLvBKECIbwkVISF3gKqUEvzbdTb4WyoX7SF4A70s5Da+amIiwCLd4NzCM/sZ53qvn5dg68+@nongnu.org
X-Gm-Message-State: AOJu0YzZvepF297ppT3hNlG8qlJvxrb7KFg2vfveMOHsBsrwm7Qwh2QA
 x+CSd9abr+dLPKF0XW+SjOqkQGlcWSsER7wBRCo5B2kM8co/6xhWWFoeSvpP1AKAngePhgAO6Dv
 p0UlfshJybHunJB5OWiLIvZ2PQqbQ7gBMsexlAAaTiLCIi6X0x7gmtTQr
X-Gm-Gg: ASbGncun+U6EmTRdhqQTJ7f0peHLgazmTA8KEa7j+5nfPzshMv0F0aqzcdXp4zldMIy
 rlAtfOFuf6f4J+R+4XG6YJzarHaEbM2qPX1lWSM0Xj9EKyn9RMoEW1Q4i1mGCev5378QeXjRC3v
 6ZZXWCmFh/BYvlhvlrEvRSXZ3oDslDqQH9FeMxqq3dpTRrOWEz7MwcFHVvwGroyqHXbIxp3gw97
 wCgyQ39x/AHEhVX74spJDujupJCjDrqenHc7byfY/NKFx1QTCy/eFiT6+LGZGe2qHwX+T+4aZu6
 EyddoLl4K0eOf+pHWt65oIHWVhVFS75QRNUX2qKDLfs7
X-Received: by 2002:a05:6000:20c2:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3b5f188eb3bmr2755677f8f.29.1752252719001; 
 Fri, 11 Jul 2025 09:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1TrT4FOb8Vpa6Zr7s9cftuT36PKiIyTz7n9Y2488GFhnm6Vk7Zi7R7nkv50yWAxfOVBB8zQ==
X-Received: by 2002:a05:6000:20c2:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3b5f188eb3bmr2755664f8f.29.1752252718624; 
 Fri, 11 Jul 2025 09:51:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd4b32d8sm51983255e9.17.2025.07.11.09.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 09:51:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/9] i386/cpu: Intel cache model & topo CPUID
 enhencement
Date: Fri, 11 Jul 2025 18:51:55 +0200
Message-ID: <20250711165155.498929-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711104603.1634832-1-zhao1.liu@intel.com>
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


