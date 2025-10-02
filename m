Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4J7x-00056f-Kz; Thu, 02 Oct 2025 09:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4J7u-00054Q-Co
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4J7h-0005An-JY
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759410801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTeyeNklT2crMhzC05vA4qxRkYde9Bzm+Wtdrb0/Ew0=;
 b=TnfVvpmgrmrBZDUMJMP+1YjgGuJupBd5bsvoN4tSA/gnzkX7BCsOWwtctck5VXO/0NeXmx
 ZpUMnMZfPHRPbGstHw8MWz1oCswJSmMvh3f4fRfcgZn8NfhWg99a1p16txSikiOgHNU41a
 XgnNH012cjPsttQ3EG4B3Bbm7WsnazQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-4alObda1OxWpnrTdQfdieQ-1; Thu, 02 Oct 2025 09:13:20 -0400
X-MC-Unique: 4alObda1OxWpnrTdQfdieQ-1
X-Mimecast-MFC-AGG-ID: 4alObda1OxWpnrTdQfdieQ_1759410799
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3efa77de998so783335f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 06:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759410799; x=1760015599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTeyeNklT2crMhzC05vA4qxRkYde9Bzm+Wtdrb0/Ew0=;
 b=c6j3ieioSgcZdf27vDea6y/SruK5jkIKjSrldlHZDQK0vChPErsuQfatMvTDqTxJ9k
 oz73ego0wBuskinpOdsGqD5TF4U31fHniAZOhZaZ3mNYoNqS87Wfl6afIjarcJFnWXmB
 a099e/cBw8aomJzYbppnuaOfetARaWTAsYEI+yzeuNdz5k6kKHqkqiKQeKyd2jnk1xDD
 RE6uHGBawLUZEO03trkkk0aBKuKCORXHSypBCu+W95yxSUreKkxY5SoWBp8XS75FBi9U
 FU3Ex1v4QNVOTHyq5ZDJGnigBbFGHlFc6IK9I0MmWrjmDRsRcnwY1AahLcx55iVgdpAU
 2ErQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtB9AuNWzJWqaPr5swJl7lVDW8wTeM0Wf3y2jCARzb8vDCAg0b0DtCb5P3u3ttT82y7x/GBuFQF5YN@nongnu.org
X-Gm-Message-State: AOJu0Yyit5pyBd1MTJc8X9XZ1XWLNbh7tpGNVhV5GHEgsTdrbQ/FuNU+
 +Uw1zVhA2D9NntgeWww8wBoOanp0ZIFERwjZQpe6FBEww8auaYMYNmyrXyry2aRclmMguQveFxd
 fHCLOg3PViS1BbS0KcnkKmwL8Q6Hb72NgVdORDJ7eS0zGQ/15anFCAUud
X-Gm-Gg: ASbGncvIfL1wggLaf9abQCV+rGnnCY2XjU90NTqMEjDkVvMkfJ2ZBCNviyQmGrpd05a
 0lsmolHPP0HKoctAui3cJJZN6k7p2NrrC4RdWycB+YN+wJSYbyQj8cnNbnqG9kzleZpWuLZdant
 GaHQXI1/bg2uy1RkOUBv62XhVI7YjS9FQJQUj6hiSoVa9h1CZc6xFnVNA4EFJk1JlArmiJJ5REF
 TCWAVyPlGcYm1+cMIs8V9mRZJfpEeLjsMsUSNSzhgPYsNayiKaY5CmalFieka7pWBtIvIxzxVoQ
 ZF08eIPbzHoJbg5a+7EH/Y4+Guxw9L0Upex6
X-Received: by 2002:a05:6000:310d:b0:3fd:bf1d:15d1 with SMTP id
 ffacd0b85a97d-4255781b921mr4691778f8f.49.1759410798993; 
 Thu, 02 Oct 2025 06:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHydgsT9ZFtKh67SGnG4V80Bhz55E09HmTOVdo6lB9F+maNnE3XtLW+NBpp4rZwO9AMZOmLvQ==
X-Received: by 2002:a05:6000:310d:b0:3fd:bf1d:15d1 with SMTP id
 ffacd0b85a97d-4255781b921mr4691759f8f.49.1759410798614; 
 Thu, 02 Oct 2025 06:13:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8a1sm3698441f8f.14.2025.10.02.06.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 06:13:18 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:13:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: philmd@linaro.org, berrange@redhat.com, jdenemar@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] isapc: remove support for -cpu host and -cpu max
Message-ID: <20251002151316.0a546cd2@fedora>
In-Reply-To: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 25 Sep 2025 17:03:18 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> This series removes support for -cpu host and -cpu max from the isapc
> machine as suggested by Igor, and then updates the "Backwards compatibility"
> section of the documentation to reflect both this and the recently
> introduced 32-bit x86 CPU restriction.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

so, taking in account discussion in this thread.

I'd 1st post only deprecation, and once it is run out
this patch.

With that:
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> v2:
> - Add documentation change suggested by Markus
> 
> 
> Mark Cave-Ayland (2):
>   hw/i386/isapc.c: remove support for -cpu host and -cpu max
>   docs/about/deprecated.rst: document new restrictions for isapc CPU
>     models
> 
>  docs/about/deprecated.rst | 13 +++++++++++++
>  hw/i386/isapc.c           | 27 ---------------------------
>  2 files changed, 13 insertions(+), 27 deletions(-)
> 


