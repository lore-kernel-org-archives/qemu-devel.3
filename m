Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04904EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voiWH-0007za-Oz; Sat, 07 Feb 2026 08:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiWF-0007yY-Hj
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiWD-0001UB-Ng
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770471515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=SqUid5UZB4dkqnt06GgPgyZdpXIOR1clk8xlSdUp+8Aip9hSPds3cs8hjnmMAzGLCWcrGo
 5WIGg9Y7F5j+Hz/shIjqs/QvesGWM+F8ErzgiHdSgR5T46ctuAKOHDK83DPW7NHjNb64Bk
 WEViNNOLn4yv5jfj1+p0DqHHpXOI0J0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-DeI9mKkPNRORoS-8i8S1QQ-1; Sat, 07 Feb 2026 08:38:34 -0500
X-MC-Unique: DeI9mKkPNRORoS-8i8S1QQ-1
X-Mimecast-MFC-AGG-ID: DeI9mKkPNRORoS-8i8S1QQ_1770471513
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so2507780f8f.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770471513; x=1771076313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gvknSXDXaChxcL9BTJjhcgS49eanI793tnUD5uz22qysJhvBxYel/LvKsQuzS2Maci
 oH2Su3g2sn4XoxHdCJ0myBWvKSwpC2yr7RJM9U2XCHqKbnSkBFZZyf1nW3KatuY8BvBM
 n26yADky5DsOaHMve4mf6VCayF6iHIw/yA9FBD7UV7/ac0Sdnw61p7H2sbs3edZveaqG
 5BlfvcLjN7hqScIJM4uivYwqKOqttClVVpQAZ6nXmHkeE8Yw9Zu0P2ZXgxahugA1oL1k
 uUy/acADdEvp+/sCO7fSdxNO700z0RHmR6hdhJAYKM9knNMpC3FyRxtA8revQlclvV+9
 hRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770471513; x=1771076313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=buWF+gYjQb8xMadsBWMVmzOC9G0akdR+T0r678iz7KuZdSAR4IDlvq1fXUYBxJ15hM
 VSsfc1E1Iz9Guec99BkKFSG9maUQnHfDbVaHDk+j6oDq1Dq3Knjy6FFRcYur44Oi5b+Z
 72cIQZIy3fA8isA6PJBqc1B1cwOovqD9W51ndaSORYqhvwcNAdJR223bRzqFRLWjXykQ
 86hdUi9HIRF9XRjmkueO6cJ1I2rPsdMEqDjHVn1Nl/hjACTy8R+JZwE8iqrnqvpMMAt8
 PoOQfNU7rMsjCdebm4QYgyM2636HFg+D/L1iVhGo5jlp3ab0hBueSOKtyQ6tAiQLvKfR
 NrRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvd2lBgq7ZjTc1hGP1PSYqlYjKR4ubfYCbOl01sef0U1BqB4ZIwPDE3WISHwWoYfbY3TDpVttWzbWd@nongnu.org
X-Gm-Message-State: AOJu0Yw/Q8uxTO+uSDhuDbcjAiLAuQeEe0aXq1TrL+bSGrJ5fboYFFIK
 nM+wuiI/zNuLGBFkQrwPjFLfHfylEyjqiUXqGmMkwrEbdnq2Jbzh3xTMjpXgULwcnL3nIjuLThr
 mluXmbp71x9SBB2//pISANshl56tDXZLQJ2fF58Uuvi/sjIVqk7y8992F
X-Gm-Gg: AZuq6aJVayeZAJ+h/EKDOXB7pvkWtI+o7sYyWRrPGXOgYyhAlE/dlRLa7k7sut2plB+
 6MHNk0KtX7woG0jTcVx/tthIcB0EUvG3DwGAYzOoyjpzpIh/EaJf+ZrBDGUUGKh5R5dLaUWtLIv
 N9teIJsfYEHwvmMxhF9U9wxAsuxsumDstjy9LQqC6QdrK5QCwylvY5b2ZNY2Mhj16yw89GQYqk8
 gIksXQeJl76GOC/rif8Q7Nz8ikEnWXY/M2AhLYsTyWJH0ulMhtCMWFEqMyT5Jry7s4MJQFVrVoL
 K3T1EbkGm213RMjIkujJMIl/6NgnTqvhzpcClMvBS4VpazG2w/eqEPECLsr5LZzFxOsQ4y5pbLz
 qzKR7p3Ed56ORVnTUCoLG0qKfABQ+5PFtbkWMk47IVbtjLuR8abJ5M9mEtpieaUkHIfLcCJbyCN
 xsrmn9h1Qu1XDjm84s2hUuetx1Q6CIzyU43R5FrrLROA==
X-Received: by 2002:a05:6000:2c02:b0:435:e520:d1d7 with SMTP id
 ffacd0b85a97d-43629386511mr9608395f8f.63.1770471512726; 
 Sat, 07 Feb 2026 05:38:32 -0800 (PST)
X-Received: by 2002:a05:6000:2c02:b0:435:e520:d1d7 with SMTP id
 ffacd0b85a97d-43629386511mr9608365f8f.63.1770471512319; 
 Sat, 07 Feb 2026 05:38:32 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629756bc3sm12193306f8f.39.2026.02.07.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 05:38:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v6 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Date: Sat,  7 Feb 2026 14:38:01 +0100
Message-ID: <20260207133801.628488-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108033051.777361-1-zhao1.liu@intel.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


