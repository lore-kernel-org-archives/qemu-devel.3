Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EA0112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MF5-0007Ds-KZ; Wed, 11 Mar 2026 12:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MEy-0007DJ-81
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MEw-0000jZ-FU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Th7u/RX3CP9hO9gTSpHYoj8Df6zAC8XmJhHyB3PeB2jcfAkKQrpDcYrj78LB5y+A00TbYp
 imFD1/s5jfqYOiklan0ZUr624bfv4sOo6oDFUqR2CDSQ69kfPBLqFp5AtrKScF7YqMhuoR
 2BHICvE8I9NvNo0/pHp65fjowjHv85g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-bnXVGWf3MT29H78bKb7LkA-1; Wed, 11 Mar 2026 12:16:52 -0400
X-MC-Unique: bnXVGWf3MT29H78bKb7LkA-1
X-Mimecast-MFC-AGG-ID: bnXVGWf3MT29H78bKb7LkA_1773245811
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so78795e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245811; x=1773850611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=lB3rvEslc/3CD5vuL5KIEDNPRrXDYa6Sw3rBbPyRNV71ihmffxeAXOKCC1uAgtvcFG
 TBPf1bKOZW19K/kQCJrShCFy9eNSHVeekUUoLcgXpFZApKIIspf0Ex/s15XPJo+ciin+
 qdICzqU3X8Swlvz/GOVLQ1I/ALXDdM5sOou98qeb4LoGq9Azc9ZWqVaLWGZU1h1YCj6Y
 hLhqrdQuAqwoYbtTOUecBQPGbgq0xeMUpwk/x5oDzO4kDcwhjXVkZwln7aiC8sCkDBB5
 PCN/gK0OfW/EtDtohPTtbgo5Tup4o+5pR+IyqiSmkFXQpgVrs3/yLQoiPgeodbLEJRD0
 x1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245811; x=1773850611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=i4piw8HfpOub60ODyCDvTABBf7+WVnKCVfGbUOoKsFCU8MpOB2fZrHfBk2C3IcDfv/
 P4Kgram2SA/Xn/lE66F9/uVpjEC+oNcdyPh52VlU8+UGiAiedqV9Ut+Wjk+xRQ0Vm2/p
 FLzdc5qqo44xFwvnSzAQiayplCxWIBdvtpr3PgMOsDyzyYDKu8XCbCQ3sT35nO2vJqdy
 4HIHFMFHnbjFvUqvk8jeMBUxzhPEv2Bf2vB9Aq5V4D+vna7SpEMvnU7/k+5s4vCBiX1X
 jHNm2E4AFsHGqA5RiHnnxnaTGAOiDxUUwhp35Mi+2Gv25OdoT9ZPMs6F2yPavmsqQV52
 jw6Q==
X-Gm-Message-State: AOJu0YwXTfqcDGxumSDgf1tYqMge1twV8gpgbqY1oKK9kPdKeKcbdbC9
 RtfoZo8BWr27vIKld938UuzorcH7k3EmDgH7TtOLxM9fQGOZ6hUayDedZHmiO5Blg8JoOFawt/l
 isUk6q5D33Vu5/ptN60oxIV5YVnMNlLlYMNkslM6CdExHhR1Vx2ibj12j
X-Gm-Gg: ATEYQzwHwUogGyaaZm/roHUiix+DV3WqDpvLEopp9dN8IAKyPaGAScUH5a4JCK0mpsz
 Ptb98xB8CVdOR/40ceYh16m/M003weLmgE9DW4BpZeK6QW+d6sHgb/oOjFduUpk6PTIZH6BfEJP
 oDfZnZctCIHxmqcQyWBBndvrwDKg7PANIGCHxcMvFZ9WRW/MPTSHLz6LqCtRbYNdkjlhMq8sMJP
 +dTJUoKHdLqWlIqb67vGe+zkelGuUnJWHUGZ96dLREqpI0DsIPnSIELvBavMYvkPtfHyv6i+9TA
 jwKRDjuVTQplTevwjgeAPUFdMDpylZNgzUYogN11g97y0OfYwTW0hCbi/q4sONj5590fvI5mQ7p
 tqbd+RTMqYs3VM8krZ07twx0Eh9OUphE2MXIMqLGpiVgDdnwHnLrVledZT7GjigegHxEf0NLx0K
 rI8UTENGbBPBbhLERDx3MBpBcYhVk=
X-Received: by 2002:a05:600c:5493:b0:485:365f:b4e7 with SMTP id
 5b1f17b1804b1-4854b0ca47cmr57984735e9.14.1773245811124; 
 Wed, 11 Mar 2026 09:16:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:485:365f:b4e7 with SMTP id
 5b1f17b1804b1-4854b0ca47cmr57984285e9.14.1773245810733; 
 Wed, 11 Mar 2026 09:16:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f255sm166716515e9.12.2026.03.11.09.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:16:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] rust: Update Cargo.lock
Date: Wed, 11 Mar 2026 17:16:49 +0100
Message-ID: <20260311161649.561659-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309172440.66409-1-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


