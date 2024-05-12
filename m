Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D46AC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 11:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s67AF-0008CN-EX; Sun, 12 May 2024 07:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AD-0008Bq-8U
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hikalium@hikalium.com>)
 id 1s67AB-0003jX-OI
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:14:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ecd9a81966so31303485ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hikalium-com.20230601.gappssmtp.com; s=20230601; t=1715512482; x=1716117282;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mobAQ5muPJ0HOT+48jssaFzfeWe7tlCSiSmEbsLiU4=;
 b=IWmcrz6yF66+jjRiN7UURIih0qtKyPkjCuuti9qXgbIELfJVKCPT1CAWnHthGHxlJu
 lQl9pEzuRag0BEtWqobDvErJ4ccxeKWVfWmOJ6EFhmnrqHaKGoT3VZ+zme5Imle2TFPe
 1EB4jLBH1BEdNimHo/SNwd2VdBHdxieQFjIM8diwhcuyXxANWRT24Cs23zVJHVtBUp5n
 pE34PiULGwjNNRapYICA1mDT4Uj+lZvH28U/4b0HsctqBHjqj93QlWWsNJ8uiX9SCbFP
 mcoVt2qGP4utj1QwFLsAHu6cnraYJ7UqI7e9gsPcGWs1dVjxuFG9YGruxgDNpCLCH8md
 HssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715512482; x=1716117282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mobAQ5muPJ0HOT+48jssaFzfeWe7tlCSiSmEbsLiU4=;
 b=d/VCO7lNc+GTIiokFuxFrIdC7+0NC33Hq2a+qCRdnihtuNPEQswTffUJConCXVuJVR
 bOp3GftWnDdpPR1MVrRmzWm8zWmiAsVwoquPVaHD99F0gASxv1nsbbCFjTe+R+vAnqQm
 Q3zziHFC5nlzPat+eR+i5aPv2u6T//PEPkJMeIJfYz9aWPXoJnP/fdt+Txfdw8SiLXJB
 nh4Q5MgiiqM1SG3O38kfBtGjCtjQULMbHo+cn3WIvuDZ3VmZP1y1x8b/Lpr9z0omjDIr
 o8gBmQzlCnfDx/IjmgICzcwB7vhDk45Hc1/1TZnCDGPA5sZ2LGBl3OnaSPrl9EBOKqX5
 vPiw==
X-Gm-Message-State: AOJu0YxpBOZlrE3Hxvj97N1eGlw7DAdNEg52MilMO4SpjswZg7niLeD+
 HbmlEI3OY11UP9+o0wgOz0144eG9BKelpWLOe/+1yqO/evBroN7ld0/0pUkedblwfTcLwlx5S+2
 2
X-Google-Smtp-Source: AGHT+IG9DIwKPcGbhs25JbHx7e4Yv3/+WliFxG1Bgtv19xDZ4gUHku2nAknXFPj39/M1KlfZGCdYbg==
X-Received: by 2002:a17:902:ea0c:b0:1eb:2f25:c43c with SMTP id
 d9443c01a7336-1eef9f34715mr146729815ad.3.1715512482007; 
 Sun, 12 May 2024 04:14:42 -0700 (PDT)
Received: from penguin.lxd (113x36x63x49.ap113.ftth.ucom.ne.jp. [113.36.63.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf30cbasm60399375ad.126.2024.05.12.04.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 04:14:41 -0700 (PDT)
From: hikalium <hikalium@hikalium.com>
To: qemu-devel@nongnu.org
Cc: hikalium <hikalium@hikalium.com>
Subject: [PATCH v2 0/2] ui/gtk: Fix motion event scaling issue
Date: Sun, 12 May 2024 20:14:33 +0900
Message-Id: <20240512111435.30121-1-hikalium@hikalium.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512090429.29123-1-hikalium@hikalium.com>
References: <20240512090429.29123-1-hikalium@hikalium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=hikalium@hikalium.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi there,

This is a v2 of the previous series with nit fixes (fixing typo,
adding component prefix for each patch subjects, and adding a cover
letter).

Please take a look. Thank you!

hikalium (2):
  ui/gtk: Add gd_motion_event trace event
  ui/gtk: Fix mouse/motion event scaling issue with GTK display backend

 ui/gtk.c        | 20 +++++++++++++++-----
 ui/trace-events |  1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.39.2


