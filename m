Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9D6D25056
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDin-00025C-LW; Mon, 12 Jan 2026 03:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfDib-00023I-2P
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfDiZ-0003wH-EW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 03:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768208165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=S8H3GF77o2loTsqs2XLI78fA4oCsXapSJlnxQojvXA3uR34VRgGx/RJU5IIN0DXl+ERKIn
 5G2ELajGUgatP9NiT6Q5b5DYz3jwlT+44mc9FLA3E2rlIFYIAk+r8csO1ergTS0Rn+MRgz
 U+/4rk4rSVM+MI82PP6j/cvsohF/0ag=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-NFSp0Ct8PPGse3U4LaRhpg-1; Mon, 12 Jan 2026 03:56:03 -0500
X-MC-Unique: NFSp0Ct8PPGse3U4LaRhpg-1
X-Mimecast-MFC-AGG-ID: NFSp0Ct8PPGse3U4LaRhpg_1768208163
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so4686149f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768208162; x=1768812962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MQPUuxUMe/i0yGZSTkyCL+mFHAEfav89qHLJLPi8oHT298LwPXt1GMor1cRNXiXfC8
 x0PIQfs7eNL+CqusSe8ZIgSj5k9zgrX0B4DhgIU+GutXNNReTzD+t/8GbllACKvY2Zqi
 4V3EMC7kfcFtmXC/kirZrd6YBE0Rul/OpApDaM5QZIE4/7c/f5nqJHR1Iz7/PcWNyIIl
 AdomtnnJnQIIFeiZX8h3aOLlPfJ92F8PlhjfSQq3KjxupQfeR5FH1QXVm0v/WpzCWIVU
 LgSK+U/szHPr46fX+nOjN9rybjvgopjBLBiVtWZzSaz3BRLb12lxZ/IhMazjsnliqK8f
 76Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208162; x=1768812962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GtGGpu8x0Jli+GboTBz2465xMjpq2VVZItfy6kSArKLnZBlZLGCvm69eOq1q6lbNj4
 VQnCvlihiVjM2hKFw16fc/LmZ10tUsQgySnbXC0a2gl3WiJNklFpu4UFAlNykQmZzopm
 A8gVC6mCsHLGOVDHq2Eyeil376AqZoJh9ScTsOq7b0ppkXqBbis4Qqh5hEu78GW2yGip
 rfgCEShtqg5NHm3LBgOGmWel/tAYnkyfxDkmlJpfMTrLK9SMBbVijj8ypf8c7193arYd
 c4aIO2UlOcmBNMV581n8Rv3JZG0Mv0/ClL+5B8vgKdxKWG0wwB0e7M5UVX8Vr1bnUuzJ
 RFlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+ewjJISEpT1B028t3lAKtm/Gouu23nLXywqcq8az8rdzRtBrL+DKvONz1wYfN6O7BEFNY2ez6tbSh@nongnu.org
X-Gm-Message-State: AOJu0Yyq7rE5SMv+AkPaLbgKNEOvrfEJ26UAWxNVRpe8SIlfXEZEPJ9n
 MPogajMjKn6c7P1yeVmE6D4KAXi0Rv3mplLMQQW347gsj3byHKlhSVVoAn1CWM2kC2uJM89gJJY
 YcS4FKFZ+KPes2NyJhm/PfVcC0PpIQGN4IA20HUuIcLbKS1FCaPEGYKaX
X-Gm-Gg: AY/fxX47mhf5YZIh18N/zzHafgyow49MENW14av9SY0GgMs2RDPdWGbL3fmu7A/vT/K
 CHl/rha6/n4KxDjAp/Fy5sjUNlxSxnqAAElgAKud0AFatSQ+n+hCaNz2ThBXKjoWrmcwZu+m1Wk
 N7KP+/5Cy4WlnXzE75qR5cPtG1gGHORwBqtuKu3FwDH8i3mqAZ1GdZN6R9NSLKuDBMqNDkrY09u
 EPv11jU06B2UvjjlHyAIwezSvKBWjU2DO6fZoQvvKgElmoIRNDbUWQpbXsHUUyvuZY+Et6uBxCk
 WtZPakcQI+6ljoqmspelmY70OmMhHTx7jQEWlDAp+lK7bCvBBYd4dtU93RFVB/bsTMznUDPjbs8
 ybPqyda6PJIMHy3DsgTlscJkp1PgPa52zsSwTpzvFzXnSnpiCHrtqKzHzi84bc+2x6V3yoCCDdh
 dAik9uVmyDmIMMwQ==
X-Received: by 2002:a05:6000:2f83:b0:432:e00b:8675 with SMTP id
 ffacd0b85a97d-432e00b8b3bmr10116351f8f.62.1768208162629; 
 Mon, 12 Jan 2026 00:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiwsQGTghOpZ5ozc2SUNPeWVHaYaQncDaxPOa165BSrGGrvwKqpMbwP/6KmRQl7FsOgUbRUQ==
X-Received: by 2002:a05:6000:2f83:b0:432:e00b:8675 with SMTP id
 ffacd0b85a97d-432e00b8b3bmr10116326f8f.62.1768208162286; 
 Mon, 12 Jan 2026 00:56:02 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dfa6dc4esm15652199f8f.23.2026.01.12.00.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 00:56:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: Update Cargo.lock
Date: Mon, 12 Jan 2026 09:55:59 +0100
Message-ID: <20260112085559.953611-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112090900.880621-1-zhao1.liu@intel.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


