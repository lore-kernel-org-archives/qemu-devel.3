Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F24C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzKj-0006IE-1j; Mon, 05 May 2025 13:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uBzKg-0006Gd-SE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:10:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uBzKe-0004YR-3A
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:10:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso2856612f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746465018; x=1747069818; darn=nongnu.org;
 h=content-transfer-encoding:autocrypt:subject:to:from
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jiy8rp/gjFDm5EhiG8J/Rynj80YzBCJAZWrtqRiR6R0=;
 b=A26dAN/CHrYCIlk7iv3WbsacqPVvm0RJUB9v9sO3k1x0z/9Y58vXltS/+CBHFivpnW
 q8xIWib4yMp0sVTZp2dDhZDPx66bQZ6RLG9dx0q38WE7rDF99G2PifUKLKebtruzrQuk
 N8R2xeVootzhQRynAlEjm1rr36isMipHKAH1UMQafA7Ec3qdLoEVZ54cshJqnYNIhPaT
 Y1kMSU+LBbi14AIzYlPnCmNHSA9Q3aytRINRX1NAGw6TH0FUiTP+hDmB4GFcxDWssV7I
 VHpvHv9B5suW95mdPxabeOZqEy8LrV460ZqjY7TfH0LgENpNq8KJL5hr/Y+dneVX7N6r
 u2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746465018; x=1747069818;
 h=content-transfer-encoding:autocrypt:subject:to:from
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jiy8rp/gjFDm5EhiG8J/Rynj80YzBCJAZWrtqRiR6R0=;
 b=BJIGx8wmcaW5bGS5220M0KKrWZ/WemKNZdrfgL9+C0t2NptgzGmUevHQTb/9zfBK3A
 zDK4NizopltJh298iuAqjajIysNtiEoIAhozdCYjecUr4/D/wu7Yybmrtfaa+4qJt59H
 BgpU9BINUmzbag8YUJfqzeA04T7tWTuTgtLigCuU8nDgtoj68aogqij5XtKSsnYBH+eX
 Eu87LcBn8P15ZppqlUaLoThk9VYM7UJDsONovZDSdOCL/un46ztANwvIrlHIXZhjeiNg
 8C0To+RgEbWnGV8k5qvInqvkC7UlFkz/mIb6JGJrwuvanSwtpX/Qm6BOfCrYnzV4OwMQ
 XHOg==
X-Gm-Message-State: AOJu0YzLx0MhoiKjEbyKLB65R6GCZH+q5UiFDQ0STRcA7DX5j74l4qKg
 1HFCnG8EtjjkEe1kd5YrfnmvIhSNg+hL8dnW3v6IVi7bRiNjOAhe3KjLMw==
X-Gm-Gg: ASbGnctctYvYDFwQCftcvigD/WePH//5vgdxBdwBl30oWbMJzSraIk1D6+2bG6koPrd
 E76JkwAVxOLBJ9WrQW4Ecy3NOt3tOxK4i2C6ZSzNIqAjndnpLFaMXQVOKleHh6WnJvStuq9mGAt
 UxhZxE8xrP1CjzCTIx7hS3qfO8X5lxlD8s4GDF96FyHG98fTXU14yI2S9/afeS4EdsT0PpdbA26
 Z88Ju2YkW+eZL/riZ4BDxO0Jp+P9yvDj0G0XHu93Olvh9dO296q4SsVkQ9w3FN/oQ7BRcP9x2/h
 tXaQAeyp2RbNzP4AHrFrqhLz7zWaDMmkpdKnRep0Eg==
X-Google-Smtp-Source: AGHT+IGtVH3C6XEmCAuXFZreOomHmPwzJNc+4m/N8MK2LRW/2wo9MW75JVmHSiMeyG9EK7hOOoRQ0w==
X-Received: by 2002:a05:6000:2586:b0:3a0:8a19:db31 with SMTP id
 ffacd0b85a97d-3a0ab57024dmr248742f8f.9.1746465017836; 
 Mon, 05 May 2025 10:10:17 -0700 (PDT)
Received: from [192.168.169.123] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16ea2sm10758915f8f.85.2025.05.05.10.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 10:10:17 -0700 (PDT)
Message-ID: <905e09ae-df13-458e-9eb2-90ff455d1ee4@gnu.org>
Date: Mon, 5 May 2025 19:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Paolo Bonzini <bonzini@gnu.org>
To: qemu-devel <qemu-devel@nongnu.org>, devel@lists.libvirt.org,
 KVM list <kvm@vger.kernel.org>
Subject: KVM Forum 2025 Call for Presentations
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

###########################
KVM Forum 2025
September 4-5, 2025
Milan, Italy
https://kvm-forum.qemu.org/
###########################

KVM Forum is an annual event that brings together developers and users,
discussing the state of Linux virtualization technology and planning for
the challenges ahead.  Sessions include updates on the KVM virtualization
stack, ideas for the future, and collaborative "birds of a feather"
(BoF) sessions to plan for the year ahead.  KVM Forum provides a unique
platform to contribute to the growth of the open source virtualization
ecosystem.

This year's event will be held in Milan, Italy on September 4-5, 2025,
at the Politecnico di Milano university.


CALL FOR PRESENTATIONS
======================

We encourage you to submit presentations via Pretalx at
https://kvm-forum.qemu.org/2025/cfp/. Suggested topics include:

* Scalability and Optimization

* Hardening and security

* Confidential computing

* KVM and the Linux Kernel:
     * New Features and Ports
     * Device Passthrough: VFIO, mdev, vDPA
     * Network Virtualization
     * Virtio and vhost

* Virtual Machine Monitors and Management:
     * VMM Implementation: APIs, Live Migration, Performance Tuning, etc.
     * Multi-process VMMs: vhost-user, vfio-user, QEMU Storage Daemon
     * QEMU without KVM: Hypervisor.framework and other hypervisors
     * Managing KVM: Libvirt, KubeVirt, Kata Containers

* Emulation:
     * New Devices, Boards and Architectures
     * CPU Emulation and Binary Translation

* Developer-focused content:
   * Tooling improvements
   * Enabling Rust
   * Testing frameworks and strategies

All presentation slots will be 25 minutes + 5 minutes for questions.


IMPORTANT DATES
===============

The deadline for submitting presentations is June 8, 2025 - 11:59 PM CEST.

Accepted speakers will be notified on July 5, 2025.


ATTENDING KVM FORUM
===================

Admission to KVM Forum costs $75. You can get your ticket at

      https://kvm-forum.qemu.org/2025/register/

Admission is free for accepted speakers.

The conference will be held at the Politecnico di Milano university.

The venue is a 5 minutes walk from the Piola stop of the "green" M2
subway line. Downtown Milan can be reached by subway in about 10
minutes.

Special hotel room prices will be available for attendees
of KVM Forum. More information will be available soon at
https://kvm-forum.qemu.org/location/.

We are committed to fostering an open and welcoming environment at our
conference. Participants are expected to abide by our code of conduct
and media policy:

      https://kvm-forum.qemu.org/coc/
      https://kvm-forum.qemu.org/media-policy/


GETTING TO MILAN
================

The main airport in Milan is Milano Malpensa (MXP). It is well
connected by trains to the city center and to the subway lines. Milano
Linate (LIN) is a city airport with a fast connection to downtown via
the "blue" M4 subway line.

Flights are available between the Milan area and most European
countries, as well as from America and Asia to Malpensa.

Another airport, Bergamo (BGY), hosts low-cost airlines and is
connected to the city center by buses.

Milan is also accessible by rail, including high-speed and international
routes.

If you need a visa invitation letter, please reach out to the organizers
at kvm-forum-pc@redhat.com.


CONTACTS
========

Reach out to us should you have any questions. The program committee may
be contacted as a group via email: kvm-forum-pc@redhat.com.

