Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BDC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHoI-00087Y-GY; Fri, 11 Jul 2025 13:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaHoE-00083o-6o
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaHoB-0000xU-9t
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752255912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NcKZxRnlgCaNWHB9e8AWLrRhGxD/+CtFgule6tqOsOXrcV8SU17f+MUNqI5d2KwBf1Lfat
 5WCVVvYgSVQDrVPPwX+CbMfMQKwb6YxnyFJNFKyTKc9uOkOZd5zNzgHYVdweAD89qFp7cO
 O6f/mmKo+Hy4CZ5cCgR0Awj9ctfiTcU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-6SHc8oO0MmqhY_pfi6JqHg-1; Fri, 11 Jul 2025 13:45:11 -0400
X-MC-Unique: 6SHc8oO0MmqhY_pfi6JqHg-1
X-Mimecast-MFC-AGG-ID: 6SHc8oO0MmqhY_pfi6JqHg_1752255910
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso15868985e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752255910; x=1752860710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=uT7CXaqXAYbcBt9GfpTa3r9zqPthPC/TAz9GjO142SaZ748lWwqCh54KSPn6LOsZDS
 yCuHEOVM0hXFp3Ddc9g5uefCjH6Myq77zCAtFhMZjhIZIPttk/oyO1iREnuhAC0ZB1EG
 4+o7B+C/NXJez5VFELDuUySdNrOgMjvbMbHvwpS9OQT1xR45nUuw6jrUm2WgkW/ZCCCE
 ovCRgv5CzWX4kdfqZ+HkKU+Adz3EpvJwKjY0Z9TYynAHJPTVFf1LPoxpcyltZBQWUK+z
 yqCK3QPTSzwcCoOXB/FsCp+pjGDC9IkRQLv/obRvvVzzROetuJmupH2g90CxD8sKfFtg
 Yrag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5JY4hRqnRik7TZ2r5OAq4PW9aN2a9y0gqIWLqxu8nUJ8fPnOKTuH2pndrbFkkYlGUiSQe7kMihm6x@nongnu.org
X-Gm-Message-State: AOJu0Yx/DMj6geYu9dtSL9A4NMooltMFSoD3E2Ufkn6cybTUAkHZ2XJl
 w0Sesaq2v2u5vybOaRTj8zOSrSTkDFrorKLWbYn5KytzX03lPDVQkfztpJZ1PeCkpplQXS7wvSy
 CDnNUTYdJ9qKPEdGDalfoWk24F3UO5pg6GSzUg/oVnEfw9hRmXmejtQWc
X-Gm-Gg: ASbGncskdlM7zgXHSJY2auQpxWwJTryw7F0oRvjUIiFrYwPUxfZBEgf65WFoYmnVvZ2
 YAui0LKmpWJMkTXAsjBf2UDF/k3uhxlyeJM4DLZRgAgscYFasFF7mAyWZOZtTbIvusLQKBjM3s1
 KJLhcgJ1QKixxYZeQJDlIVwFz5QbSq6bs4ujkd0yYr0scGT9g3nN56aJJxingHTZoT1ZYIeRHDD
 nQ9yG0z5uSXjELGdMnASFzROpoJF8jkdNoQy6E8CVfRXehRMJY4XvpCRmhbivUbe2413J7HUZqg
 LvDN5+mzP6Tr2iRI1rlEB4Gx06bK0ZVjZdZJsPDT2IIz
X-Received: by 2002:a05:6000:270b:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3b5f189621cmr3260104f8f.25.1752255910063; 
 Fri, 11 Jul 2025 10:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7XEYiNnEPmDUdHWfrTeF156IWz7jW19TXB6zmpEx6SVH0RJtIpu/xYWruOw73kE/VGK1D2A==
X-Received: by 2002:a05:6000:270b:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3b5f189621cmr3260086f8f.25.1752255909592; 
 Fri, 11 Jul 2025 10:45:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14e82sm5065771f8f.71.2025.07.11.10.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:45:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 00/18] i386/cpu: Unify the cache model in X86CPUState
Date: Fri, 11 Jul 2025 19:45:06 +0200
Message-ID: <20250711174506.508152-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
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


