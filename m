Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB23DC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9UW-0003Vy-JD; Fri, 11 Jul 2025 04:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9L7-0005oJ-RF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9L6-0000ti-3a
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuGDmCLt7ABrdD1Eunl7CW4lAQRHaHRv9w9msWFPJFA=;
 b=fqQ5iKNaMBl55ibXgpnWfRUifWaDRL2buvSnWmQ1MZY8uaXSDjTJaWrfvvBRaI1+YUgsL4
 hFbr6GO6kOwU93i8ob2T7SJDYsZlAnrE7rZU1fphC+XCDyxM+R57nWxnfDxYUfmJiHvOeZ
 wZIdmylomj04TBqla+5leNfuib1SHcY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-mzEjZTZkPFuvmvamwe8PYg-1; Fri, 11 Jul 2025 04:42:36 -0400
X-MC-Unique: mzEjZTZkPFuvmvamwe8PYg-1
X-Mimecast-MFC-AGG-ID: mzEjZTZkPFuvmvamwe8PYg_1752223355
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso190591066b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223355; x=1752828155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuGDmCLt7ABrdD1Eunl7CW4lAQRHaHRv9w9msWFPJFA=;
 b=EHSPnAA8aiNr+AVlHKt1TspCM/kAzwO/yK4Bkf4E2M6KjQXLpnkT64HwSUbHe5u/MQ
 qldQHXdEW8tuoAat6wgPnlvXI+tWiumWHgQKMVUQ5zpHbmtc5ukMUCkXk+BAd1cqSM/i
 VX2kSyHrQhHl0QHCYJ5FgoLo4kZOnO4XlBJmHh++2Yv/8wIoWzpEdNWfKGVZWGSO1gQN
 KEuzQntmeMA8HX70Cm5BQC78eboM6fnB2MlrkEZOekS6dA3m9Q1w9HgXTQKId+lPMy1X
 UnkaZa+nQ+bLfti55O3uKBXYGHYeRqAm2/layEGRQ7VP7o/G3JiJjUHtr8cRhPQWN642
 VXjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnf4XCeDyxZ0503c6s9jSD3wdc0048ZvwFjOdFTpquagw0CWe0gcg0iQTeCry/4CYh010WesHexbIS@nongnu.org
X-Gm-Message-State: AOJu0YwKvIo//alu+DyXvrm6yCvaTH7LMi0kBiOosuyxjs1u8QXSX3+J
 PDN6FHxKkSZe9Ny16Mx5GtzTSNHu8y+iGCYPjb5KalhFu/S4I5oB3OGWvFWcMjmFGR8Yj3Q19Ah
 R44hyxI07t56TTJjiuM8/07woJugtrMdMHel+UTmKyHstvUOPlu6Oh4N2
X-Gm-Gg: ASbGncsq+SnZcZgUgR709PAqoYTtPZrpsZolq9h7UAerr3oJ+1xcXcfdTBfnmKLwMRk
 gpG9/ZMnfVF3u/SzMtGddVMZV/IQX+G7FRkyeCk+Sy8N118EtJRfC/73zYhCbjk/dghxtOz8Gip
 GDVRul3JdARhm4wzqHz+fS9dg2bY24AxWqx3j+vpHjgTilTNqhwbFpiAnOC7ZU5zpAq7LE3+Lr3
 X8/HfpSD/qhPXZcMCqYi2YlZgEAAvquMzhpz5D1It1GS8/BEDFTmGko//YadAZzFX6LZ/bgyZd9
 PCNUIxRokeg5QxKvHvWlitj+3Bp462aeO1ncYxkUhn/bNi0Q+MMJ1GNqVh4ozMsh9WjL7bhN6Q=
 =
X-Received: by 2002:a17:907:3da8:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-ae6fbc17035mr270090466b.12.1752223355201; 
 Fri, 11 Jul 2025 01:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqUibMuz5OwVkcBBwWvHA7G8fJkV/K2VNmRcEq9WN7CuwtWimm/KgWh3fyrf48WUMzMBN0w==
X-Received: by 2002:a17:907:3da8:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-ae6fbc17035mr270087566b.12.1752223354722; 
 Fri, 11 Jul 2025 01:42:34 -0700 (PDT)
Received: from [10.35.88.123] (93-44-61-216.ip95.fastwebnet.it. [93.44.61.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e826469asm257280166b.85.2025.07.11.01.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:42:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] Clean up of target/i386/host-cpu.c
Date: Fri, 11 Jul 2025 10:41:41 +0200
Message-ID: <20250711084140.457739-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701075738.3451873-1-xiaoyao.li@intel.com>
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

Queued patch 2, thanks.  I think the issue in patch 1 is also clarified
by merging host_cpu_instance_init() with host_cpu_max_instance_init().

Paolo


