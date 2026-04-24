Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38909FE51F4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCtR-00063y-Eq; Fri, 24 Apr 2026 05:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGCtP-00063O-OH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGCtN-0002Y8-9y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777023127;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJAkUBjtt/FwIyPPxsftVyolb9XL1ywmNYUToUTrlnY=;
 b=bJSFQAccZ9xh665i8ne2O688HspYza5BMpaPyeLkiddvRzSmw4ZR7/0SXEcZLmygc7jgdV
 qfXMm+zL8XckXZZT33recIYp66DNPNOlxfSEDtYMIwbvuPafGfaTX1ALg8/ACQ3FNuZals
 eIirnNYQHd1hY4we86My0Bcxfy/FC7Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ntPv-xtjPeClDPf_v80SWg-1; Fri, 24 Apr 2026 05:32:05 -0400
X-MC-Unique: ntPv-xtjPeClDPf_v80SWg-1
X-Mimecast-MFC-AGG-ID: ntPv-xtjPeClDPf_v80SWg_1777023124
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d1fec59c9so4812037f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777023124; x=1777627924; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DJAkUBjtt/FwIyPPxsftVyolb9XL1ywmNYUToUTrlnY=;
 b=PW53geS/++1rnKge5ttpZiFbgAeL7TH9IgSC1nizbYcWDd/FW7aHTMWwiQoMfFHnv1
 2+beO8PDYcYprHV7s1H591O8DZE4pegC3RR3DLquzsRxFngxiurUCFZZlcKtsLCLlw2r
 qupVA8QOJwTTprXOa1w2fcjKqGPphETOSOc9irqevKCJgV4nMp51pDs2MR3UpGKPNTPR
 IWGGDHQ7/bVDVHP5QC2NbVcQI72q/ajDtKc/mX7xLFDtZIU5cde3ZvI5Q2NiLkm0anhG
 2qbXomWMR25kaVLaPFpfobQXvBYGxqODjnPVYMCe+iKdZZC0Uli6ruNeorvCqtyCaC4m
 Y4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023124; x=1777627924;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJAkUBjtt/FwIyPPxsftVyolb9XL1ywmNYUToUTrlnY=;
 b=Rhg7BFOGoJ7Fx7Yd5IitpNTvoL9kKGAujd0Bv8/UHgZTiTGtHYvRtPEgj5tIn+24rf
 RCv02zEumKzm1/zvaR9BEclStimRcARnJFDeLdzwW8/VYAPl9cAI5WAbyyWawc3tfm/L
 /TGWUrTJ4H6WJmHwLBqMf9jr4Wqovy+bDNI31/F4AXZ7+H5vvd+4F6ZyKmzIL2Ym1cWe
 a8qcOeCpXJnAjsvt4qKUh5BhKCvVBzvYCuU24Ckw/G97uXG8r3+yAUaPQcS+W5uRyDRv
 8orPGI97dUORP1tbqGyvn3/BUQM/aRN9BDp9LnwOd732uRcwysJ9Kkv1xVfTNtDEqkcU
 4BpA==
X-Gm-Message-State: AOJu0Yzl+a92V3kwr9l1NUZewTRWotrfz6wBruDEz5UmnYvIDigYM6ME
 XGCjiXc6vqIsRo3TZGCdFTJ5+CXEaNwfBXd43bRuseqOwVurLZZObT3b4lGxA/vexzahkyufOwh
 GURX6NnWcLi9LTsM4KCfsmLKMsAg2Q+Tw9DmmkkH7oDaSgwaYjhIZeFSP
X-Gm-Gg: AeBDiesNYNPS55UQ1y8wD5Y0OFmUDTdE0CVZx/99hXf3vovci3q4Nh9jGEUJsqR5yoi
 o9RpsGX8loh2ya2Hs5aDh/lJy6FOTAkhEzWzpXFIWRkMQws80wjqmHxsWFVehqs7lj0n3hjZqBT
 uULAf19OUvHZ+r9Ej9ZUB0Ra/k0DtWcqMfxyQhfeDa0JQoMsg5DzIvFaQQgFeuueBA2WthjSdru
 c5DhhzThnI/vIQMS0KN5Fqbe1aU33d2J+Sr4HSUs58Y5wFYFVKfORtu8DR8xIK/RZ2hcjaH7Ppo
 YBJwBCt5q9Y2Rchj95ktU9k8pGP6n4KoWcHiIQk17LSUJPLJvM/u0g5T2hMEYl714cAezz3495z
 wnMMJ6ehTdlbSxKT5+/JmR/dMgpVzEw==
X-Received: by 2002:a05:6000:44e8:b0:441:1cfb:2024 with SMTP id
 ffacd0b85a97d-4411cfb20admr16991613f8f.26.1777023124318; 
 Fri, 24 Apr 2026 02:32:04 -0700 (PDT)
X-Received: by 2002:a05:6000:44e8:b0:441:1cfb:2024 with SMTP id
 ffacd0b85a97d-4411cfb20admr16991563f8f.26.1777023123781; 
 Fri, 24 Apr 2026 02:32:03 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm59101456f8f.4.2026.04.24.02.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:32:02 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:32:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elisey Konstantinov <elisey.konstantinov@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Message-ID: <aes4kEdQ_x8eI-m6@redhat.com>
References: <616E96C0-F0A5-4A9E-A63B-3BC1B5F18094@gmail.com>
 <aeswZxFn0zMj-3jb@redhat.com>
 <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06C2CFB8-BA33-46D6-9F84-B1F81A2A319E@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 24, 2026 at 12:19:19PM +0300, Elisey Konstantinov wrote:
> I completely agree, but in my opinion, investigating UContext will take a considerable amount of time, which is why I took the liberty of proposing this patch; in the commit message, I actually mention that this is merely a “temporary  workaround”
> 
> So, I suggest:
> - Merging the patch into the mainstream for the convenience of users (as, from what I’ve observed, SigAltStack is coping quite well with the task, at least for now...)
> - Whilst leaving #3276 open for the time being and continuing the UContext diagnostics there
> - And accordingly, as soon as UContext is fully functional, we can switch QEMU back from SigAltStack
> 
> Also the another arrangement is to use UContext ONLY if PPC is in the build targets, but I am unable to do this, as my knowledge of Meson is insufficient for such a task; nevertheless, I would be grateful for any assistance :)
> 
> P. S. Anticipating such a reaction, I DELIBERATELY did not include “Resolves” in the patch notes, so I am fully aware of all the proposed precautions

PPC MacOS guest is such a niche use case, that I don't see a compelling
reason to make such a change in git until the ticket has been fully
investigated and the problem root caused.


