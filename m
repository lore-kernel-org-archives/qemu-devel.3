Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E2FD5304
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvrox-0007Ag-Bi; Fri, 27 Feb 2026 01:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvrov-0007AH-9H
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 01:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvrot-0000r3-Gx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 01:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772175565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=adq2cp2X3QgKA6inAmDUmACVxlGUH4/6uKfXWmHVAI1lf1oXzb8UYO1jCiBNR6qiJFY2N5
 IUzszJXezXWGmHvSylFqUwFQD5KroeMtpCyV9dDPRqeVgiIbqMLFcPWIxbNEYUmjIQH76V
 tDNAvLj4paB6wC8WiBllsFTiqZdLZEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-qGzGScgDP7i2Bfu6_6E4fw-1; Fri, 27 Feb 2026 01:59:22 -0500
X-MC-Unique: qGzGScgDP7i2Bfu6_6E4fw-1
X-Mimecast-MFC-AGG-ID: qGzGScgDP7i2Bfu6_6E4fw_1772175561
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so19190575e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 22:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772175561; x=1772780361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=IpSASS+unMA7PhiSGIL2Poj/28v/7HKMVZuYFf0CGIfmK0SFZGSFB3Yce0TMokGM3S
 RBTJFU9DEdTKwm7MdAqJGk82aE/Q/5hQvR/nkulUtuMcH/3LLUdKNx3hr2F0nZVBW8Ii
 fxlO4FkvqmNrYLyqumL1ZbMvXjY/PdMhBegO8RmDzeyyr02VzloTSMajLL0fb9iLr3E/
 871KJw1UHG/3RPK2kpIWoWVajZBmOjl48gajqj1gmm5Y+1MECxIz9LQ5vGl1H4beasIu
 rFVT7qitiJxcq7q6iEgVkJv62YCi8nTRyUX2a581T+9T5r68qC+40K9GAQF3dTOIIqDi
 hPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772175561; x=1772780361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=bvOxURG1/Yrmz7f51vk9MpRRvP3i/Ov0sMXxu3ltPri4UiDl1D7cSaLzY4nKcpN8lD
 XcBeEZG/2unS54pwNGf8PC1AbnuzXBW7LROzSpERDtM7Flj+WHjcd3JJgccYtWkJ0GlT
 9478x0g2Zzba/ymMzoIkcB5EpHf2a57mMPa+++Lzlt1+povsB4YhiQ+It6Kr7KgagYaV
 qWYylkIYR8y1NpxY5o3TBstlVODROn5FzoeI83yAbVn8CyTuxO71L3JblGb9xTTM5jba
 Lq0CyhCuUMZtSziAmxrI6iTYGJLcYO9JFI8oPfgxSPZwDZj0XCCZH2IhHhkPxBbJjoQ/
 26ZA==
X-Gm-Message-State: AOJu0Yy+9XPr+2iTAPHV2ejeITlQU1lBGPiIyzFpIBBqYOv5V2y7YcxN
 eUrc1IuVG4Mh5umDJa1EoEthGBo9AAizkWAz0LhkXjsQBi+X3+O85A+2RChlByvk8Gx5cVYh4K/
 9AnQsnxpajv4Uo9/BwKfYcxMgPvKH3gEYsiGbKjZ9EWDravqoPj0Zwrxo
X-Gm-Gg: ATEYQzwzx0gPgT0y+TUAPGfYHeqIR2CyH1Wb9tF2GKeD27MpF7KpAlFqutzX5CPUi1v
 Vq3dWqymtGrju8XFejUPpHQv0FEKiFsnK9c6MLJqxzWQnbN/xWHHn9BkaZbOknlH3CnYaKT/Lyo
 6WjNteg8B0hWiTm+QBldL+0BwL77oqXH7T0SE7IlbtPGyrGTYb0BzoSMUE1tRfDcikr7MBC+Kh0
 t3AQZS5xglWq6HyYSUcmnhENIKcBwd8PtO+5xN4gCcoZBaqYDqZ6AN+fRZ6yeaGzTwpW5CQCE1W
 IElf0mdlnYkIrQx/QCGecN9bu+AafR+/+ZtTdYy7vwM3g1z2R01AOTzwTrL3x6jnVTQyCxm406+
 K/SZbXpHxSpihTFL3dTwbQmuIN3wwKfUUoEW6wcO3RHUxohN1NoEGzIUV+0Tco1Pkk4gSLPrp59
 FwRvCGRxgF7VVkCmavSqWfba4ampA=
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483c9bc0344mr23217185e9.12.1772175561324; 
 Thu, 26 Feb 2026 22:59:21 -0800 (PST)
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483c9bc0344mr23216955e9.12.1772175560933; 
 Thu, 26 Feb 2026 22:59:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm195161155e9.10.2026.02.26.22.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 22:59:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: Re: [PATCH 0/2] Reapply "rcu: Unify force quiescent state"
Date: Fri, 27 Feb 2026 07:59:15 +0100
Message-ID: <20260227065915.71507-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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


