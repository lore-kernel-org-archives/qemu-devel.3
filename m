Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF41C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tixv1-0000r0-MA; Fri, 14 Feb 2025 10:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tixuz-0000qT-EM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:47:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tixuw-0004MO-Rp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739548069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=H0IvIME46loqxDMPlzVC0ikPURE4Lrm/gHDLY2AQjqbftb4Mo8yh9QPONdK3pZiGJxb0Eq
 gAia2mky/wVBmXAFgxLWaTF+PAdnaIE11NHkcvLJDeKCQwmSW3voUa3UDcEOEpuZKif84Q
 yRJ7AU7CFT7xRgOxU99UpIDtBfyDR3I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-JR5Bl7eJMNuP7qpvG6JD1g-1; Fri, 14 Feb 2025 10:47:47 -0500
X-MC-Unique: JR5Bl7eJMNuP7qpvG6JD1g-1
X-Mimecast-MFC-AGG-ID: JR5Bl7eJMNuP7qpvG6JD1g_1739548066
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so216771966b.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739548066; x=1740152866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=syZdj9UU6JU4AtZ7LGO0pPTj2ofMpZi+Kln/tIKr3L0OloPFfg9Gq+G38WXOGYleNx
 Wlq+hLcEPz8A2x2ts/7ddI2uVdHmm3vLWCFefPsTagH3hrwevwIsW6YtEk9OJfLtJsu6
 osiUBf3We6Uq8OqavvlmIjYbPaCr5muH2Eidbbh5G6eaSOtz7MDjqfhOLnxgiTGMPEZ5
 cjMQutQUbZiWeJR7AzcVBf+eGue3U+AxQn6Yd2hSY4leUzh4QQYWkMgooYVlt4SwtzfH
 QrCMazbnR33IhmCxh4M4eQqh8U7vGJ85C393Wumxy57cWBC6/OT7PiaZL0M7NvV4eP5t
 plxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnT4FsypwknXW107zLLO7hR3f7nSDz2EsFHvMzIhhMrWlyWtxP+gvfuLuRpEqZJX40aDTT3jju4KRq@nongnu.org
X-Gm-Message-State: AOJu0YzsbbCXDFdrrdzoCrHMTzWIlp47X6eDaz3to6evHuMNcF52RmV3
 CISNSbqGM99BNYL+2X0xInma2YRCtyXEkVUkDs7u4SBMKg9sG4jyGIYBGieevMXkRxS2FQts3J/
 hivFNhmsyCtdlWDqrd9Ei/ZF8Wh3xyVsVtje5BHndUv2Lb17uiIgz
X-Gm-Gg: ASbGncvv9xESuSD8o2ly8vUhchfvRKWeaMKjvAIP0M3sYBWQhWWvbvSYgM6O8JgDOfs
 5DdjMrPqK0mGH4dVM0xZof6pqn7gP/sqKA7p+a3czj3qziBM8AFwS+an5npNf7YlraJJ4IcXK3P
 +E6MA0xkfcS3Hh5g3824DzFiM116IcP3tAi+45Ixt0hp8F0MN7ysU3OPLTP/ZrHU0O2BilLaNGr
 /fq5wdOKqGwtEBVMsKBbJsD5vJSKg7j9S7QJG77xIy8Ke2AMMnIlreaQMGnZxSgDtPuZCTEOa2f
 cg7NhlJE+81eJg==
X-Received: by 2002:a17:907:7d94:b0:ab7:798:e16e with SMTP id
 a640c23a62f3a-aba514984f8mr669987966b.15.1739548065787; 
 Fri, 14 Feb 2025 07:47:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo+RqEVueji3GOQbyEUXKVYr2AQObKj4UOoBv0aqfdAlrpi3SKLUlOHVMnSpLTSWfD6HgreQ==
X-Received: by 2002:a17:907:7d94:b0:ab7:798:e16e with SMTP id
 a640c23a62f3a-aba514984f8mr669985766b.15.1739548065386; 
 Fri, 14 Feb 2025 07:47:45 -0800 (PST)
Received: from [192.168.126.123] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532552a2sm366611466b.52.2025.02.14.07.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:47:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] qom: Use command line syntax for default values in help
Date: Fri, 14 Feb 2025 16:47:42 +0100
Message-ID: <20250214154742.4086148-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207-bool-v1-1-5749d5d6df24@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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


