Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE6DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxZA-0000Mx-CS; Mon, 05 Aug 2024 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1saxYp-0000L0-V2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1saxYm-0001uC-Rc
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722863734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BQAqkOI7P4U3IWYXhpuHguud+3t+IUquf4iJMA0SvKPyKSlmytZ3VfZrqPr70yog3TgXa8
 6rf3ctPUamvl9+EOpBEkw+8OBEAG8js6sbNV3o3Lmh1bbJQCdtI0gF6UyV/QszN0vdCLlK
 Jks34cGtzN+EfY8nbGmCcZgvXHMPnvI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-nDme9TzTMgKLgUZJFr1LEQ-1; Mon, 05 Aug 2024 09:15:33 -0400
X-MC-Unique: nDme9TzTMgKLgUZJFr1LEQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52efd629749so13469731e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 06:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722863731; x=1723468531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dwOd4EbneAUuFn59RC1Xqcg5id4sFYT7v0V3jmEqFj4EnhOkdtzoYVP6AbARIPs2gN
 ksUxWxkBaFFuav7lLCahwWZBHMfKFPPCVMicScXceLaVyd0yqLxUFZYd2XLNyqP25Hca
 dMIigUwZQqN5cXV7oe+KT7E/A+wVtyZfo5EDsg7jWpEw7YW/UtGXtfVm5fWLadZgIACF
 3qx+epuIZ36zvDX1Qkd43+1HUoh+L3OgI409IXY1+0+VQq6okPbEtsMC8GJiLcYVuu7D
 RqBf9qmrS6AswNpHpbUzwgyxl3Tu2A4Nc6q0j0WyczCkuYbeSwOyaB4Snfcbe2Lz/n9H
 /QjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6sJxz+3kg4U0nteVXvaG/ip4myiInHmcJ03FkQZx3KZnLk+vCDrLepq3hM+VAKkrhq32HGlec/T9Yko0rjmARp9YqE9s=
X-Gm-Message-State: AOJu0Yxh97tKhTHBHyqrBZQfDRNFg0vxf7nROuYcI7CdYqjaI6npujnC
 KAF/979ToeW8oauOGAky3Ks4qXlJ9A0uMryqGJrNDTLzz0VFmKLjl3/JPVIKfzzkf5TnOHCQQIe
 fiWFsqqDXay2OF+AwqCm7ttZHXs/syjKlSFQqNKw+QZgA5rQebt1m
X-Received: by 2002:a05:6512:1323:b0:52e:95dd:a8ef with SMTP id
 2adb3069b0e04-530bb3837eamr7942704e87.27.1722863731255; 
 Mon, 05 Aug 2024 06:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqyxy1W6+Nj6WrJmHMcoZHh0Fb1T/ADTtC9xHRVQNriZth9jYgYH6oMy3FwJDA5LcywMrAYw==
X-Received: by 2002:a05:6512:1323:b0:52e:95dd:a8ef with SMTP id
 2adb3069b0e04-530bb3837eamr7942677e87.27.1722863730606; 
 Mon, 05 Aug 2024 06:15:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437d4sm451267966b.132.2024.08.05.06.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 06:15:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Brian Cain <bcain@quicinc.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] target/hexagon: don't look for static glib
Date: Mon,  5 Aug 2024 15:15:28 +0200
Message-ID: <20240805131528.489043-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805104921.4035256-1-hi@alyssa.is>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


