Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC8CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eiI-0002Z7-ON; Wed, 08 May 2024 06:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eiG-0002YU-Jc
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:39:53 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eiE-0006zf-9G
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:39:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59a8f0d941so1105708266b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715164789; x=1715769589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nGnFTXM8KK++Z/SQ4A+jJFbmLigcPVN1oAHF5uTd3fU=;
 b=WOADextJi3lhkk52IvI5Tn+LWMSc6d6Yzc69vmuVmIOMroF5fGhPPpwsbyZdN/9JE9
 o4V1JsDuJrmY0jLoslyBAl6JPc6MLntPx6dzCpwT9xbAKuA19HAy8Pt3NdtA/BVP3vwg
 EkC7QFZe5IkwlHc/oqD16WkjgE6pZt3otUzpBWQwkeias/xmX2AFTVJruLQr5NyyNrmD
 7fbd7VlnU/9LQUDm6UZA1aFDef6Ali7J9vrRdojG9zRAfo/6ng44W6nKQcAtyHq+xQi4
 MtB/+i7qa6cXa+nZyRh8jo8VpfRBjVclTtY/Etr9gsVmNReoR5lznCwDXLdBSUQio8TO
 ZxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715164789; x=1715769589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGnFTXM8KK++Z/SQ4A+jJFbmLigcPVN1oAHF5uTd3fU=;
 b=ILxWOJ1s656zU/KshGlE83Treb9Nn1fOEsZhn+oBK5mP4M1RPt4ju29/K29t3F0WEX
 dJWGgrM4W67D+dqUWaLginzLvloYpfM9xdF96qELrlOsmbL+KTiPJbt/VePYm6NKH4Lb
 FnQw0ri1Vr82t4hj0H1VPIVN3iQpUwR0uW72h50HP3YjkmgXeyU4QapBzB60y9cgC5Le
 d3prqL3iavZX96TTRdhubRofJxE70rBTZeaYROP+sglYybtncRjtiwOuSbf5We9J9+JZ
 9Oh5rEsFVPxCs//HG5rSWz1hsRDTETsSRTiYKK2gwGI83d4QpbItcnfnplYK/gASVl5e
 E2Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1/nSDMnPwJpdIQIV8ZhIdB390lJunJHrlaqLTm7Ca6LTk+vr12uESWGfIkkOIPl9+FVBcPcO+DCtPARRZKLFUN0fBxCY=
X-Gm-Message-State: AOJu0YxLa2naKV6zw4l+zeK2H7qXj1wMOZIbITDypHLovefmaxFXh76L
 Dtrh+/RAkYha9sH6PGLPnGnyFnwNSjjabT9h35rCyis6qxJWNuatBOtRf2u7McQ=
X-Google-Smtp-Source: AGHT+IFijF+Bt1gU2IaA7P+T1BHZz8c6e5uv6zSIoGwrA+WEDPKfYBbUVJpcX6RE4e88UBupUThY5w==
X-Received: by 2002:a17:906:355a:b0:a59:9b52:cfc3 with SMTP id
 a640c23a62f3a-a59fb95a4b8mr120590166b.29.1715164788816; 
 Wed, 08 May 2024 03:39:48 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 r25-20020a170906351900b00a59b2683971sm4794850eja.187.2024.05.08.03.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:39:48 -0700 (PDT)
Message-ID: <d82d5e29-c1e1-49bd-abd0-f7153d693d06@linaro.org>
Date: Wed, 8 May 2024 12:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] vhost-user: support any POSIX system (tested on
 macOS, FreeBSD, OpenBSD)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/5/24 09:44, Stefano Garzarella wrote:

> The vhost-user protocol is not really Linux-specific, so let's try support
> QEMU's frontends and backends (including libvhost-user) in any POSIX system
> with this series. The main use case is to be able to use virtio devices that
> we don't have built-in in QEMU (e.g. virtiofsd, vhost-user-vsock, etc.) even
> in non-Linux systems.
> 
> The first 5 patches are more like fixes discovered at runtime on macOS or
> FreeBSD that could go even independently of this series.
> 
> Patches 6, 7, 8, and 9 enable building of frontends and backends (including
> libvhost-user) with associated code changes to succeed in compilation.

Indeed, diffing ./configure on macOS:

+Executing subproject libvhost-user
+
+libvhost-user| Project name: libvhost-user
+libvhost-user| Project version: undefined
+libvhost-user| C compiler for the host machine: cc (clang 15.0.0 "Apple 
clang version 15.0.0 (clang-1500.3.9.4)")
+libvhost-user| C linker for the host machine: cc ld64 1053.12
+libvhost-user| Compiler for C supports arguments -Wsign-compare: YES
+libvhost-user| Compiler for C supports arguments 
-Wdeclaration-after-statement: YES
+libvhost-user| Compiler for C supports arguments -Wstrict-aliasing: YES
+libvhost-user| Dependency threads found: YES unknown (cached)
+libvhost-user| Dependency glib-2.0 found: YES 2.80.0 (overridden)
+libvhost-user| Build targets in project: 6
+libvhost-user| Subproject libvhost-user finished.

-Build targets in project: 707
+Build targets in project: 713

      QOM debugging                                : YES
      Relocatable install                          : YES
      vhost-kernel support                         : NO
-    vhost-net support                            : NO
-    vhost-user support                           : NO
-    vhost-user-crypto support                    : NO
-    vhost-user-blk server support                : NO
+    vhost-net support                            : YES
+    vhost-user support                           : YES
+    vhost-user-crypto support                    : YES
+    vhost-user-blk server support                : YES
      vhost-vdpa support                           : NO
      build guest agent                            : NO

      berkeley-testfloat-3                         : YES
      dtc                                          : YES
      keycodemapdb                                 : YES
+    libvhost-user                                : YES

---

