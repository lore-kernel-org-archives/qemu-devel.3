Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA11F3ED43
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBXPj-000266-Bu; Sat, 11 Apr 2026 08:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wBXPh-00025j-0Z
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 08:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wBXPf-0001AS-2W
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 08:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775910367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ehbhvDYc4sSfrtKZCt3qx+FqSwj3IZoGBdWxetp9sI3Y2jrTHJhk+hBtPeHgSyllKGoD0Y
 uv8Y7oOXNIQTH1RfU/K/cG019xEsyDZCp8xOspBnJsBBySEQkJD+1HD8ZwbIwo33uxjlxT
 L4H5r/tLcP/1/I0bnc3Q3DXYpj8CBfI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-pYQx8VE1OrmlmMQZeo5vlA-1; Sat, 11 Apr 2026 08:26:06 -0400
X-MC-Unique: pYQx8VE1OrmlmMQZeo5vlA-1
X-Mimecast-MFC-AGG-ID: pYQx8VE1OrmlmMQZeo5vlA_1775910365
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488c213b485so19739085e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775910365; x=1776515165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZHTXAsurNgQ7JaIbVc+Wbev6j+VIsOZxWRDZpH3mXA4fKe9hBi85R5HgBSQw33qe1c
 SdKeu39wSJ2eO/NWAOp9l6fXegiENNQ+v6CZ3wlNS6jdEWMPOntnsNrdhebQewYS+Ug2
 Wemhb8F3NKdkWWwFgTTEShC/ClEYcs820xWDwviIPL8i4PGbEMrK6duiUtbuzLsWokfM
 Pxw8i0wZPufYhX46Sijfs3Ua+8+Y2p0FQNFnuvScrvVNiWTfhh9nJvgE8srlfDkBZ327
 GEuDypJYvV53dsAKoMJn8AmXkl1Q7bB1f2AkVKrP39doOY3YK1Cbd7J9OHdA9K7USeRY
 oqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775910365; x=1776515165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=J2N+IMT1H4XWCiK6i8+8gK9gkUUpM9rgkzMImN2d0pPOGvF0dVL9F2qzRL3jGbqBYi
 CqIM06y8NsigdGo7Vwdr6pDTmQ0aK7oIdOnmlr9Al7HKpC/ltyPfwAbpJDYRDhCwSWxr
 qV17TlrLoKTgPqcS7HH+83vUGEiM8d03mIbHThzFP2ZlqUz8UUfTdUU1JmaAv3RNCgnA
 pzwN5FNcjq8mim0Ul0gM09YkXARnKzogVCVpqdyiuPvcBA5m244y1wYuUWmzO8HFhre9
 UYakuom561PPS1ydV4OBcrQ7nTx/U8NcQ3GkQadfIGHBX/pHVQKJc8YSG5DDeO9s/UWO
 dfLQ==
X-Gm-Message-State: AOJu0Yx4OiljeDr3BRn4nb7/qXLqKmKJKroGScSzfORD/HW6yINNxXkk
 pLEf3VO5gUoxAlKfS5+rRrK1NyXWGfbqBKCq8XhuMJAc4BlYMHMXNSlUsjqIv/2DLsF5G/NqtSf
 5aNKelZedSImmJNOIyZI/zrDnXUy1Nj9xc0HyDYVEzqoB1EOOTv19c2aE
X-Gm-Gg: AeBDiesB6N95JMdauEAkMh2/+WjGUfXuHLaYoCZd77oGbbsBexxB2faZWi42h8SAu0C
 AA+VW+fVLSQD2FdpjZ/JyJMOluxj6hMGFZBNAP6mJhcRhoJaXZ7BYAW1DU/0ixUMHDruo8FjH//
 TDcsixxOYB+S5lpS3LXNTGLDR2QBsuL5JnL2nLkXpU4z9wgYQdeZAxCyNhJ2h3ZkHK4YGP228xz
 gTVqvHVkYt5CAid6uYSrUKQWMANfp3tFv4FUCAR1+eEcMYJxWBw85xzwgl7/Qi0A9x/Qf+WYTgW
 VvCzUmXt75YqtEzfX8+huUBkTM2PfhPro1g2QTcwbIcA4CU7TSqU3dFDi10YydTzvUxxGQD4ggS
 SOv7KKrNcPHeYNUauDh0piaH9/+AiyyMDji7MY4LUosQV5oEJYSMUdOSkXEfbawYXrMI30Xijqs
 1KHxMtVh0sMPBeQ93ORjbdJQ46Ii3YurLM7a5wEmc27hC1QVZxAIH+8ARw4s27EQ==
X-Received: by 2002:a05:600c:c0dc:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-488d68105d2mr59766465e9.11.1775910365214; 
 Sat, 11 Apr 2026 05:26:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c0dc:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-488d68105d2mr59766235e9.11.1775910364756; 
 Sat, 11 Apr 2026 05:26:04 -0700 (PDT)
Received: from [10.251.239.123] (93-38-178-167.ip71.fastwebnet.it.
 [93.38.178.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5df260bsm46367315e9.13.2026.04.11.05.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:26:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH] target/i386/mshv: Fix segment regression in MMIO emu
Date: Sat, 11 Apr 2026 14:26:00 +0200
Message-ID: <20260411122600.87767-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410142652.367541-1-magnuskulke@linux.microsoft.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


