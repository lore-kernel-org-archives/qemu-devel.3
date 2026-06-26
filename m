Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF2CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0zt-0007zx-1V; Fri, 26 Jun 2026 03:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd0zr-0007zc-9a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd0zp-000062-RF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782458945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5p51mmzxeI18JmbILm3U1EkTVGJjpRuRcXnqJ3FlNUE=;
 b=LAkB7AXsh+vUaqRN3A7RFNwQifDX5qQALWa6NtFahspqv4HqjqKsJAQZa2FjkufOggSXhk
 cP+phNXxUV9UlQ0VxQcyzOiiviSjKEi9odye/Wl/9lND9o6SSfaU9f+hhqSAIiucnwCe1h
 WAYNZb6QYK83M9HwQgv0y/hEsE2/loA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-JBT6RtCXMFG86DtKXd0W-Q-1; Fri, 26 Jun 2026 03:29:01 -0400
X-MC-Unique: JBT6RtCXMFG86DtKXd0W-Q-1
X-Mimecast-MFC-AGG-ID: JBT6RtCXMFG86DtKXd0W-Q_1782458940
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-461e0dad8easo392515f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782458940; x=1783063740; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5p51mmzxeI18JmbILm3U1EkTVGJjpRuRcXnqJ3FlNUE=;
 b=pIZhalpdt+wERuwzfS/y6gmCz39triE/6dpeE2XRXc4FEsJVWPFfzUnZxKLBrnAmrc
 X/mrwEolChVnPp67oKGjB/fg6KVdGIiU0mub3hswc6b6EWD74zE1gKi4qjb80SYDQFRD
 ZJGUpNYWBuQ7miwl8r4xx+u0eHsoyxdae6Wd61bQeEH0b7BlaQ5Ei/nmy9D7v0htEZNC
 CLHLn9YUXSxpFpZsNlo15szWTmewLetmXsox2GwTgDk4QHyZv9q+jgDjvo+x3NxEFovu
 r4bCakpGHuI1nMwQ65ZDHXUT13R7VXbxKSQN/ZqDR0pYEi63xBICsopaDgQK62n+qVUY
 H8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782458940; x=1783063740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5p51mmzxeI18JmbILm3U1EkTVGJjpRuRcXnqJ3FlNUE=;
 b=iwAFLKkjvKdafBqlKUE8KesMsbXM6vuhjtb5ybsS3oSPaPOFVHiYUMcC8C/K5f/uZh
 hAZHJJkq9wFV7Vhn9/oYtti9Z5A4qDDOy4dlcRSYOZmbUDjpPJhlfL6IAY91RlaBvdoq
 C+1nEYi2dhajXGOipcZ2erwBWAOPELbQYeVMiyT0r2U0ufsFDKcAdUdfOkOqZwWfgJgu
 tnILH7IUpgRjBXoT0BTD/kfO3Gnd5g7rHevTRIs2PhALx6yVvrNH1F0u56ymYzoGVtMg
 nyPcYqQ/DJEwd0pg3So9UfvDZzG4BBLr/PPYD6s4EM9ETWkh1/MEuUmbVverHOeZ2H6s
 yFkw==
X-Gm-Message-State: AOJu0Yz42/k3o+mFcmpoujvC7Fv7Q7imWraW3CvM/G5+f7iTc2SWu99n
 7ep8MQNNE5oBlkYxExHlB4z/uXmMsqu6/3HS322LVDFpSvsXEHCFECCM3F2FPlfGy1gQO/KLBX+
 GddJLZujHYt8f2KVbPjgY7vlxCRhoOZZfvs2Bg5ABgLXxgiPyPvGU8oo50zRFmNo2PUMDLPoSUi
 3V7yD5GDy88RD0z0bwRH20xeLv/WbdrSSsqd3o+AWu
X-Gm-Gg: AfdE7cnq3nmnw9+eGBYfiuJ9RKhBuFhBiRFzIw5Lpho9qA68J7VL7+6oBBtyZoaX/yv
 dCqsKC7AFIMLwY/LJ69jNqJz5h6q0CceeGVlaJphm2o3vdzvaEE7EWMV5nx6WtorrK3l8Q8num7
 WTbv9cpXyt0RopYWwuWLNc2Tjy601Gds2v1CuVpK0MiYtecuo/k+q0ZC/RvQyf6Ny2/i0948N8l
 nY0JYbCk0Hu4JN1tJs6w1tUyeyunqVj44bV9U4/YqJkUMHuxUjsvvMKca7xnrcAdrqVlwNTJqBr
 ADdLlFAPUzXtBofzkW+owNNZa1L1Eq9jpDJ59HXBKbg3pLDfMz9eZxuVkfaq0MrYDhOlsgR8I79
 ZhKEkHjdj7L1uZuDL0t+XgD6uvNsb4pqCR17NuLmhpMEK2OQ=
X-Received: by 2002:a05:6000:985:b0:45e:b21e:f840 with SMTP id
 ffacd0b85a97d-46dbfca2953mr9407144f8f.8.1782458940354; 
 Fri, 26 Jun 2026 00:29:00 -0700 (PDT)
X-Received: by 2002:a05:6000:985:b0:45e:b21e:f840 with SMTP id
 ffacd0b85a97d-46dbfca2953mr9407107f8f.8.1782458939948; 
 Fri, 26 Jun 2026 00:28:59 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dd5f9da4fsm13538770f8f.23.2026.06.26.00.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 00:28:59 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:28:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 0/2] igvm: device tree support
Message-ID: <aj4px-G_Nex9j2Iz@leonardi-redhat>
References: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

On Thu, Jun 25, 2026 at 09:56:18AM +0200, Luigi Leonardi wrote:
>This device tree will be consumed by Coconut SVSM with the upcoming device
>tree support [1]. This will allow SVSM to run on a normal CPU
>(not AMD SEV-SNP) and execute all its tests using upstream QEMU.
>
>Eventually edk2 will also be able to consume DT via IGVM, but the work
>has not started yet.
>
>In this v5, I'm adding a patch that simplifies meson logic. Adding it
>here to avoid conflicts with patch 2, that needs to modify the same line.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>

Please ignore this patch, this will conflict with [1]. Today I will send
a new version that picks up that patch as well, fixing the conflict.

Sorry for the noise.
Luigi

[1] https://lore.kernel.org/qemu-devel/20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com/


