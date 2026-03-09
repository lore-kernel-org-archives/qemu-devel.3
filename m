Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A241FF3C264
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbFZ-00066p-E3; Mon, 09 Mar 2026 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzbFU-000665-77
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzbFR-0000BN-IM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773065176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gvEa7CQkdHNFFDhOzm8m/pVqZnk+OB+qucsHO9b3KFzei5d5JrlV8Baz9algpKut0xFK+/
 a5MYFIT6CycVokqBy8CpJBTkf3XbT2mps/iopIdLNqAnw3LI71HwTi4tsrvEMoVGQ/6oxt
 rxjvm4LPkNH60QoZrz61CES6bp87x1E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-wezj8T_qOaS2lSBoL9f43w-1; Mon, 09 Mar 2026 10:06:15 -0400
X-MC-Unique: wezj8T_qOaS2lSBoL9f43w-1
X-Mimecast-MFC-AGG-ID: wezj8T_qOaS2lSBoL9f43w_1773065173
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b50320a0so6690903f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773065173; x=1773669973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OGLukAcvMIbiy61TnwQiy9hFXv1BM2l++XDe/S07Rbd+BrTbNuQ2xE3Y9XTih6XIib
 HyPYhSF0k5kFNqOaYe35x6HIvkF7M9ApmkHmLNrH+6fhmS4q3QkclZQfHkwNi77sQ6Tx
 PtOIO7o/iBVK0C48OG+hNy1qGUiwJWHMh8YKIz28DllW+lrIVKd+RbXY6vUCZHiSRun5
 coHcrINY10Vk5t3zXx8P0NjAwSIDUOhs4UXyzfmqibqmB9G5tqdwxwsOASEr7GIaxdK3
 cTebhf+++PVbnhkqpg7q4zxd3VnjH0Wr+9JDpa0e0Jyhggqa97CfcGCyon1LpXD3XvEH
 o0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065173; x=1773669973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=uCH7oF4feai7X7coog8hP4Wc0dzkjkbQZ4GiAq8u3UZlm9j++15iENpXjN3Pr9JCok
 y5zXQuAFwH/movEZOsR6V3av4cz/mhGDl71F05vdnQGCSFUnE9LaatzsopornHhA/fh6
 Ma2RU4OLSPh8rsuFHRa8Tf5ym4I91XXXCGSyPZJSxvgtPQJxJHxt5WiWeciTmdDePFRT
 moukTquXPZkARnXuP2mPWGoay8qck3gEM3XUuuV1WbmbjTGcEyLmckp2kTnLro5T+CIy
 7hA14GZ7L0NFWGT99WhbKkwAbe6LXzzwI8Bs4M6H8RJ/fY2HygnWg0lCPrzpjEyosCVJ
 V1vw==
X-Gm-Message-State: AOJu0Yy+hBTxRcb4H8J81LOif/bVug4hDI3h1u9f+i47bokuGHnIdHUr
 z4etIWblIt1j+XDHa+CDmFhr9cvMRevK6ccFRpyvKujTCvt3ieb1ax3Q4P4cCTvPvwzV9KwFLvW
 Jvro0WJ1Pt4fdV2Kjv67anyzCHdvhy2MeEQ2rQNMsgDt6V0kg3DLQC9RV
X-Gm-Gg: ATEYQzwJqdQszCGShXqntWsBs2P/6TRg3HDxtxr/poA6IJQ/Jf/G1cpEPIcEoFFa8YF
 Pw3wynPEoyvJ1mheZV3/N5+xQoW94vAW/ZRw1YpWoLpa0HPnwoYyhZApZtfLnTHK7BF6btuRRf9
 8JiRz6Zylid1Lc9Pqr5cSUt2jLOqp1GtXF/7k5Ly78B36ZhcfsURLq/UMqHmWMSJ6up6n4YrxmE
 02eO8ihM7/nKIc74EqPq2IzkhK3LQ8KSVtZnxfLMo6+LggFW3JYARYboL3ruclwh8KtpteAcN+Q
 VPPrzKm0WGGeHelwwrL/LSRxCDzrGdwHbYyiZjA8yNlR2y7X7+rw0o92tMbULL978tXGguq9VzE
 ZWg8ly0jz3FvdSdtGIk8q0Civv0CCQ5Tgue0aNxoZXdyMPRlRvLhNnrhi6kebqoQVaDw6rJ1w1A
 B7nSm/LcK0sN+8dC1+htjsC3eb93w=
X-Received: by 2002:a05:6000:603:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-439da32789bmr18916884f8f.3.1773065172839; 
 Mon, 09 Mar 2026 07:06:12 -0700 (PDT)
X-Received: by 2002:a05:6000:603:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-439da32789bmr18916824f8f.3.1773065172295; 
 Mon, 09 Mar 2026 07:06:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8daf2sm27473130f8f.2.2026.03.09.07.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:06:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2] hw/timer/hpet: Remove HPETState::hpet_offset_saved
 field
Date: Mon,  9 Mar 2026 15:06:10 +0100
Message-ID: <20260309140610.111240-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306093134.27789-1-thuth@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
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


