Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566AEEA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo05-0001AF-P6; Tue, 10 Feb 2026 08:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpo03-00018c-Op
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpo02-00038E-Cu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770730913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=K4Gof2Bz1puVOnTkLnd0XSFqVrz5H8Kw+QaZWcIsCqy2xyk2inDknKR7JN1K0EVcI2/Z8o
 2S4tzGn3rXUWA4j4IqpOnR9KQbuJ10NLZeOTj2isxwrGMIVaIlPtgFwa1RoaXda1zeK1BP
 U2qbm5D2SkAJfV0ejezRRq5t3wqfwnc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ZBmiVK25NOGNa-Cp1R7HNw-1; Tue, 10 Feb 2026 08:41:51 -0500
X-MC-Unique: ZBmiVK25NOGNa-Cp1R7HNw-1
X-Mimecast-MFC-AGG-ID: ZBmiVK25NOGNa-Cp1R7HNw_1770730910
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cb47edaso48794175e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770730910; x=1771335710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=B3oUvUwkBh12hno8uPwcedyjHJwVh9NqQQMDS+eb37e03h9iVMydd175gUZ5kL90G1
 ffhK274JRKlkhwASkY9L8AbGQyU6GpKRMINNY7KZbmVNJBkj5HYK+WOFevGq8vUGwAbi
 Vv4F7JLUKlR9jFN4ONkBDJJo7+o+Ycsol0ByVjLns6ZhAHb1jX/+PwvXmKrDkg0Q2L1t
 coxopcXa3i0qS+aU3pXdKWS2p2cc195JeZVOPIpU9HbQWHVyNMwO5T1zduEvb2194iOn
 mu9vj1JQ/oWPLj88WLCxqXIzGgThN/ueQGl8wsOVu4s+iLuVAZ6x+AD5cmq5MjtPCOIy
 vsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730910; x=1771335710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DRcNWjWAnvo/Mejgbz+8n5JwcpGqkT45FKhjLM1WfuqX5zlB7dXefzGrm/PB7BhivU
 5LjgDEcMZjNTTbRr77LPCe0M7tNVz1CcntyPEU4But4AVujuXQDIemdPNQ3dQLH9lhhC
 aJkNTY9bBrr+NSaRkX1yRtr8xxujrOFc7iiv+9lrDWsbyy7/IUMyBNp7NOl/5sg+lJjk
 e+M7bL7gXne0Zu/39GK6RQO+FbnnbMybrNJlfDbmkcE8ZjcRJZT+lhsJlDGK/sV7xYJl
 +FSxn5ux6x5+fQ8pPUtswYDWjcdJliOT1bmKEYzJZGlXB440Ti7jEj2dCK0/k6j3aAMX
 vbPA==
X-Gm-Message-State: AOJu0YwGeuiemNpLQIIPME8a3aL3dGyhCAYJWiDLN0tCQUtE+GpEELJM
 9hTHd89wVm6H7HaImqlDMlP6p4APxcRQaYwN3SkLm3ZQFpHOUlCV/z7X2qpF2+/4s1ltIxGfQb2
 ++5vuE1wi7RoMPzqejeb6hdmeBAOUE2+kfghp9F85iRwVcJY7PctP3zja
X-Gm-Gg: AZuq6aIJ5R5Xx1IQtS/M4P4WUXIg16nNlcSvadwxMc69zj6woAlV+kNaCuAbQg/4o7P
 7Bac3PBtGv9u3PIP47ZXAF+7fOYD4B5K4lSG2smPKcVJE+8U/Zm+DAe9+DAFYQj3xlyy6QTCE+W
 35s36cnUQ9yCZBc5cXzamLL1/SEbIsaez733u4YKjd+R/9llqNw7Q99/YZte4OiXC1gYMZrhc4F
 0p9TqwS5rHG9anErz8srJZwPbTSginf5vCN2HICI9SSFN5Ieu7Yl2xKn/Jo+DB0PyvLBpr0O0GP
 6BJcEPLTtWR7qqMatQG0VgtL9H8nsFt0HMpDCObLvdkk7JJzvX5FVVZ5z3DFxZagTocy6TrHvl6
 ktArmeGCIRlS+ecVj9H96kBaJXyZ7BqsmJdP1HQAvrBsqS3Ar4IK6uvvv16/DjKU8LOD0s5S2Of
 b/ELqVKCC+QgjrOYeJHI0hZPKsGQ==
X-Received: by 2002:a05:600c:35d2:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-48350547564mr32532485e9.14.1770730910365; 
 Tue, 10 Feb 2026 05:41:50 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-48350547564mr32532185e9.14.1770730909968; 
 Tue, 10 Feb 2026 05:41:49 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e63b9sm50325115e9.10.2026.02.10.05.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:41:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
Date: Tue, 10 Feb 2026 14:41:47 +0100
Message-ID: <20260210134147.918981-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


