Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DBCFD8FFA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgDO-0004dM-M0; Thu, 26 Feb 2026 13:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvgDM-0004d6-Gf
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvgDK-0000Fl-Tw
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772130953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=IckqSIyiYmc2Q1XLwCUrpJFTfkYBo844BzWwC5grMqDRCK+8YDzAmvWOtymDIO9oVAjkqW
 q1F1KlJdmNehgKkJZdbZdN5YLWRAVas5tBs1nKxA+4joJjFGDYCQbZEM27Rrn0Y/CTe1T8
 PIpLr326r2q8OeLs77q8j4VcZBMd8vo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-710JjLSnPwCF2QiO8u_lIg-1; Thu, 26 Feb 2026 13:35:51 -0500
X-MC-Unique: 710JjLSnPwCF2QiO8u_lIg-1
X-Mimecast-MFC-AGG-ID: 710JjLSnPwCF2QiO8u_lIg_1772130950
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso9852075e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772130950; x=1772735750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ApgMowhUwVdeOCegmPNzg7T+0D6VU8Tp6p50TQSXP+nX9YKd+uMpishz/pxIHaYACj
 yvthyz9Is3F7HuH47tXv+bB2to+lCdMVC3012TC7QbZ4GWoy2bipu/RudpEeWh3gtzFh
 vpKUwPHjddhMDRJoD1GgkYBFuHDxz5LfzCcRoeH8X2W0nHPxjsfGUwNxWZFLwu8rGz0N
 c8n1AJL3YRpWTI+cYc2mlfgwVp5xUDgTetGTmkeB7G0SwTxagLCAfh0NTUnxSmCKhxQI
 HzKKEKtT996N+eVREOvySt7EVfAfJYrXKS47W5PCezlg6De03RXZAnfL1kcE1TMy6JYP
 j5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772130950; x=1772735750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=LU1ZSyDeXKBhEN3IAqkFgSRxvj+LOQw8x1raGqk+rDXYaKMexzsERnMZUp4cde0QEn
 IjFif/iktGm5Key48jpv3irHe6eVdg8RUExsWtX8VGtQVHnLvnummRHGdvy8Rlv/tQ4l
 J/bJiuJVmARllO/5x5leHqDUN3jxKCWWrB3c0Mut+xL8hKoDggGen3DSOm0TNWrJ1RDK
 GSTJPh5u5iRom5JuoKTxtxvX4ZE9x+FEEqXxQaxt7rWrOodJroaBfU5xlvs1t3/XLyng
 v5FLkUcSPCzOiB7pQFRrWbnDbGzy+9D+gCvj9nzwYAARJpLUzbeO4niIFMR4mNEYaAzI
 +cjw==
X-Gm-Message-State: AOJu0Ywa4N/RmX+CRbOpRK2bIFuYGvC/m7JlglJ464tunlylaJyDcYeh
 sTUeKzcf6eL0ZO2OceQb0tt8dUfu4/gYdBnOuMUZOJpSskMlhLhLNwDInFn4Uc5yHhqvN2g7vQo
 JGpQcMNf28N8wrMOxfXB4VxcE92j33mc0S7+1H/6PEdupxbdsl0vmqZsM
X-Gm-Gg: ATEYQzzuYM4Ou1QXcuH3Efu789vJOgNDy/PxO/7EtNfeHJiCeE47pYwXFrFlUjiD0gm
 A+TuPuUw8iJ22EGSs2tCndlRtFzUh4ESERAulY3fdjzoAdzlkMB2ER+r25Uxu2Dzsa4pXR+n48h
 0UqjcyaejpC+ztVipVbLPVvxVWddDMDG/vA5DzhZJDR+smA8SDfg1QzB0201Ff6mOaeOzCz2VFq
 LAivaSvXf+URRzjFAGZc16BpjcYLOCcEb3QHy5sljznqtAACayOV2K/qWQEGZ5UTgOgIjcfloBM
 o3eORyK46jMH3O2/423Dui5tFqJhEfCUwcXYzaQX5b6vYbgl7iVYJzQWS9Ewj7bdLYgQn/flN66
 N8cgmfZiGHB6chVSck+5G0dybCZ8SQrJAY/woLA0Hxhaj1D8UEhYitprEXpovLEaK6pO17ebvqG
 vzWATKrtYes0HTWx+cgalzCj0=
X-Received: by 2002:a05:600c:3e8f:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483adc6b3c8mr299787635e9.29.1772130950324; 
 Thu, 26 Feb 2026 10:35:50 -0800 (PST)
X-Received: by 2002:a05:600c:3e8f:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483adc6b3c8mr299787245e9.29.1772130949921; 
 Thu, 26 Feb 2026 10:35:49 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb465bsm100484755e9.3.2026.02.26.10.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:35:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/3] whpx: i386: interrupt-related updates
Date: Thu, 26 Feb 2026 19:35:46 +0100
Message-ID: <20260226183546.64481-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226181930.53170-1-mohamed@unpredictable.fr>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


