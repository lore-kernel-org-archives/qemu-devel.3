Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E403CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Og-0005R9-Jz; Thu, 21 May 2026 09:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3Oe-0005NL-Av
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3Ob-0002kZ-7s
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779369903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bthRsReiJ6bBSDWfUl4C+rA7io2uCIvhq3b4X9FNb5Y=;
 b=JsR9sei0N9hlEjQDVZ+U94ZVdaXDLtjjVvEzbLh+Mp7QYVFud04DhgfUfFHR34DJ0ul7Xs
 0nEFSb8WEExyVglOSra63UpOw4WvAt6udbdyJ7LFYsQcDFYo14Y3F6ziyS9zZRCqNK+DjS
 giY6vikk52Y2nM/CPmR/lrsUUovMPPc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-oetf-rn0NmG3lIkVy2gbRA-1; Thu, 21 May 2026 09:23:41 -0400
X-MC-Unique: oetf-rn0NmG3lIkVy2gbRA-1
X-Mimecast-MFC-AGG-ID: oetf-rn0NmG3lIkVy2gbRA_1779369820
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-447f2ce5556so4872231f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779369820; x=1779974620; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bthRsReiJ6bBSDWfUl4C+rA7io2uCIvhq3b4X9FNb5Y=;
 b=NPD7neiUR6nuM2r3JRtqsJ1oNtPyf0L2XpSRh8tm4bKf94AfU6f6bFK9JyN+wK3kUX
 UaWLJSuwMzE2twTCJ0VdaYNQvqoOaTgXn6YolzH1xHQWmjBk5R1WoIE/e4nDqUEfVUQM
 77O0BrccogblJgVClQ6rt3Gf6gzq1ZS6WVSROunNtWgkCcnjAoxk0bdl1ueTFDsjrMrA
 C/TmbnI67ZX04GqNlwKTLykqCpcNg9qwY56q5vG211Df4GO94mGS6yAC4qQeNdBBDup1
 8laR7FFjFfl2s9Ixvaeisfbp8fNlRSimBmFYntRjARBQoZEHRLu9RF2g5CpAJVMak8np
 RQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369820; x=1779974620;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bthRsReiJ6bBSDWfUl4C+rA7io2uCIvhq3b4X9FNb5Y=;
 b=ZJZnuyGOSyXvEBasbuBSQtSPrGvcygM3pgGim8OCSHMOXRPmwBNwGFjfR4SOBke3vf
 75obFATC6CKMLUBIISH8HX3bnhTlqZ3evHRuj6AF6t9Q3OH3X/mw6oC9FnkC+pZMmNC8
 dwVurGEjtgDtYuUsGzmJeefzj9L6qa4MosG4wJ3AKVR7jqV/AlSeuSOQrARJZmM2EZah
 kRxR2TQoAcli/VqjtP3tMljSHjjsxDWRwFhgU9hq6+uczDJkAgztqH8w+kjaCNmlYm2E
 tfDLvI+CrTrG/DhHd/RUNU0S6Ag/KK17RJV7bKO6Zg0lakCHRBx8o4bt3Vj0/jfmCYLb
 8l4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pe6Td6T8YblBE43rWL/XsLu26zbJoZtmxTBV7egPKMsABHL+3kWGVcgL9OzzU2fWFRMgElidmA2UI@nongnu.org
X-Gm-Message-State: AOJu0YwhE+cLtwCnBF9QleJfzfIm9jSAwNr6KXlPKmP/zAZ/NZkOIAiP
 +8H/OsfUdTEwlyVuQsDLB8ZxvECsLnb3ssSK+tTupEuoTlDPBw6DDRlBenr3qzB9ZsxGYqHWK//
 6760TZ/S9ijrhJ2KymrGQBtMie/+a7Vg9BRQiE/99jmgMpXoKL8AaUoZ8
X-Gm-Gg: Acq92OH2StaWkn7vy6iVX3wpEIee3ZdnOg9k89TNP0PwfDnblFuZoZ1OMiQZHGMRL7F
 qQOAZ5ksy46HfVVQQKUXsXWk4Pe1WWHvWAePNyrx4hpyqX7Op2AmbWErG+y1IlzkA4mT27rWr3L
 IawntOIdHu6oLn0GvfXPSkHP0otEZ/3hca42IPfEFD9vW0alzowkpmj3CaFme7TTMICQKZXm/vF
 vt/Jcr2YvuM0NJvGO6RM/gnhe7csGPpz45/qrAD+cjpL9LzlVmYFpCtAijAecIDzF66mOkh7UWQ
 Z2AyxmQt/inG/jLId9tlDoI+tJikYzgB0ZosqE2LgHi8iIZvusaEBT950K2TRUaufOTvD8CXUrg
 C+tXH6cXVCDjnAaObGZ3A6ysZIlmG1c4PCaeak8hfAzKlitXclWH/i21XCnXG7UV5+P+TX5+BZM
 SJ/8RaGg==
X-Received: by 2002:a05:6000:4808:b0:44d:1338:46b4 with SMTP id
 ffacd0b85a97d-45ea36b42d0mr5074888f8f.9.1779369819929; 
 Thu, 21 May 2026 06:23:39 -0700 (PDT)
X-Received: by 2002:a05:6000:4808:b0:44d:1338:46b4 with SMTP id
 ffacd0b85a97d-45ea36b42d0mr5074819f8f.9.1779369819402; 
 Thu, 21 May 2026 06:23:39 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa93630asm2673560f8f.25.2026.05.21.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:23:39 -0700 (PDT)
Date: Thu, 21 May 2026 15:23:37 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 04/18] arm/cpu: Add infra to handle generated ID
 register definitions
In-Reply-To: <20260519132905.145643-5-eric.auger@redhat.com>
Message-ID: <c0644ecb-fc85-3180-e11e-99ec154a6e15@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 19 May 2026, Eric Auger wrote:
> The known ID regs are populated in a new initialization function
> named initialize_cpu_sysreg_properties(). That code will be
> automatically generated from AARCHMRS Registers.json. For the
> time being let's just describe a single id reg, CTR_EL0. In this
> description we only care about non RES/RAZ fields, ie. named fields.
>
> The registers are populated in an array indexed by ARMIDRegisterIdx
> and their fields are added in a sorted list.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


