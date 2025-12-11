Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5905CD41C23
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 11:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTepT-0000uM-FV; Thu, 11 Dec 2025 06:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTepR-0000tk-CR
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTepP-0004lx-O0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 06:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765452441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gBrU8wLRGJaohOWvQpXhP62E5v2WuU7czb0k825infYqI2yynmt6Z8/xsNUsb4ZbsbH2B6
 LRfZNPVuCrFrsnxHdcufthbC2grXRTf6Y4cf5uYwtVH3ieGm2S+Whyh6AFDAezXxcQ/+z2
 fP5d5dYG0AUdI6Ora7/X00DrQCZhlMI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-RxpHDhdFOvmKx3l3sdQWQw-1; Thu, 11 Dec 2025 06:27:20 -0500
X-MC-Unique: RxpHDhdFOvmKx3l3sdQWQw-1
X-Mimecast-MFC-AGG-ID: RxpHDhdFOvmKx3l3sdQWQw_1765452439
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso6364945e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765452438; x=1766057238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=tHHJbstYB5pxj+AlcpwuN8UAcQXNS0iwgLQOL2SOk6pw5YK24rtiFikgoLUaj/FLow
 C/Dtt5Ec/WH5yTQnoERW+2JxJAVsDlTo7J/m8VjdkIpte8ItXVsvxCkheXWzeYarkoAZ
 Ve5VHecjQZl1rf7sJeyXhVOrXRxKJJXOfSsO9BvJnO6NC/JYurUGYZMKUIRhdGaDXEeo
 m3Ob1QH4b4lw2xAkoiE7DU8AMDRT02eoq+d4pJaY0D14GLGdMXtJZhDFdBstnddaCQNG
 WHU79Q4i1QQTAGLDdgN/hLdBzPRaWyex1pinqmQF+VWBEyDho3f3yKI4PEH0UaR/A693
 5r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765452438; x=1766057238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=doqjwHtxE2xCDRBkWXgAVc6AUaAkdB+4F/J4iFhfrpwoZrbquP0OnkubF67iKPSLxA
 it9N4SUL2j70AA1YjaMbXg9A6e003sIAkxdPVzl49QsYi2HDCrKYFlmyKVMUzuHkq3wr
 2eDLTxC/vqfwiDumbjjXL9/ZtOAvZQ2wjUAll2fhXzRwoDPW6WgAQpxuFSb9LwnHkgLo
 wmrzEc6Jn+Ou17t+aylyOXGM9Bi6xl62vKVEJpmGlvMQBhoxrgx1kNaVyMhq0Kvj+UKb
 zNqThiN8wiECjeNKujh/ryPn61bl3cpydfrJ6kVS1Q7KQsZd9t3X6G9kzrQOEq0obO09
 EWGQ==
X-Gm-Message-State: AOJu0YyCB6MnWRDCldeMa4t4vcv4ioazhOs1e6rEnykR/ufJT+TdVLq+
 0c6VZTz5afrlqDjgCffapFzgOpKLPTQdJ/A0Hzpw680ibr26f/l1yKwsZaNDqf/EUxAwX7ABEZc
 ysxgptwvAhEG54UECdrokbqEMIUKsp3RzTjx95bNEpwOJTxMIJYIgclH6pj7108DY
X-Gm-Gg: AY/fxX4ZRqAAw56BCWbmMR+VdfAdz35YiG4mwJ9TNWSgnNvjmHDFiZINVz+yTbtff5n
 Gs7mNk8anJ3sGO41mjbsJTi+Rpp/pNp0nWeGjMUE6dMgueWrFkLF/At3L/4hrAOcY/J7yPDSDzw
 VknvMFbLUtGE+WGmGWQIEHRnTjbIychuYNtXm+D4ImAWjzzn4cSZyA8OT5q3GXg8mmo+gPj/LVk
 pZcqTrzB3fqkMR/YLvq2syhG7akq31A/tcdKL0ubUvSWXpGqpaSU3/j6YXRnZrXPHBWsC+cremH
 /kW1cWdpxtM9xL8kG2ASQHJ9fT9PMDIUFjhiFHdlIBOuw6sg6vODcV7H7pUcsLnT3ZZzBG3e2L5
 R+ACKjbLiEVGx2tjlwf7JRBayb4kBLvXaNZfHkW4RsJ3u1IftTef7UAkfIi5xEq6XLsMRAwSl5e
 WfRYcpqpPIwHa97tw=
X-Received: by 2002:a05:600c:46d2:b0:477:b642:9dc6 with SMTP id
 5b1f17b1804b1-47a838643d0mr52550335e9.34.1765452438140; 
 Thu, 11 Dec 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd2qsDberuCLqBu8bmVBFHSIEONCx+C2w1AFr4UNeSmAyFmJ0VJWKPLYf9kefq2FUU0sI/9Q==
X-Received: by 2002:a05:600c:46d2:b0:477:b642:9dc6 with SMTP id
 5b1f17b1804b1-47a838643d0mr52550115e9.34.1765452437748; 
 Thu, 11 Dec 2025 03:27:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89dab141sm29868735e9.7.2025.12.11.03.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 03:27:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] i386/cpu: Correct comments for CPUID 0x1D and 0x1E
Date: Thu, 11 Dec 2025 12:27:15 +0100
Message-ID: <20251211112715.1133562-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251118080837.837505-1-zhao1.liu@intel.com>
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


