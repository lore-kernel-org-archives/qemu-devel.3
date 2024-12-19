Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B6E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 01:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO5Rp-00046g-Io; Wed, 18 Dec 2024 20:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tO5Rn-00046J-Ic
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:35:27 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tO5Rh-0006MI-KF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:35:27 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso213660a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 17:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734572119; x=1735176919; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2letbVtdXJVj+KV246hjhtJtGyhd9lB2GmLhyI36v50=;
 b=SbgXR3wi4v+mOT4PikwpLjuAyHL41SqkmeaxRnuOip4zdQVoCfgGqjshdW1NpBFmIE
 qXIb4iU/tyirPxnU5RdNjzet3vmOZoB60r6GjyjdFVScQL4HiUnt/onPSH50MHDMzTCO
 ialjQrJWc6fVkH1PFviUMlgd8pZdGIbY86x8tbUd3irFGSSc/9wARuWV3lvLSXcfCsCp
 rq0wMubUfUBL7tlxW/uY27W1VRF8b8Vrps+Jav8GBbY81XxdqjZ7LEcYSSoW927C0/PD
 5NYgdIS5dvuWuAOSBiqhK8Td9pHc6sYcF5nrbXmL1ChjoBbQGS+fcKC1HOOwANaCDggB
 Tlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734572119; x=1735176919;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2letbVtdXJVj+KV246hjhtJtGyhd9lB2GmLhyI36v50=;
 b=TuTRceaO5yoKSJXXgSZ1mc51zcP49WMF+8SGZqzmpeJWck2Tb89kkC50o1p/6zxm3B
 2iQ72yvlGJMdX7A0MgGx4Z1NyLmfM5XhAmXuCeuTSN5eqTAbZFbmKkgpA/b8XHjUlrBz
 su/ttMX1zauhUzRggGhPhvhCFil9KLHJmhfT9gE1AvkCrHT9G29urkAiDKraxNPMeyBA
 8QG9OBuVkWd8edw9j9VK2+w2RnfcEp7+PNe53Gfwl9UNfRV6flCyDQW/j9TKgS+HxdCe
 QlerFWeQDOUFVKwaPZF6WuKotb4yrB7kdntLQm2Vdz06yivIMIeuLHuGosDPj7Les102
 CWsg==
X-Gm-Message-State: AOJu0YzLTfjlyky6CmfZsqUVQWsv7AyOkez80PkoXvNAH021AcwGFTbc
 n7yEHKwrzCVnBY6G1HGEwWsPrVpj3vr4cNd2nkaQP2HIiU7eNyT3hK9bqQ==
X-Gm-Gg: ASbGncv7M4zJn7jRgARtV/3+ML0nrBwGhNJN24GfUIi0bHr/xJWog030w/J5JnTCnso
 lPvQ2+h1Q8oMPf/RrLbzB7zDHc0Ph+nqRt8iomCiFzWYO7VdWbeOnxcSympteWo+pS+987Hms38
 t0XhcOYfxkyLPZyNp1+dGwspg6oqbvZw9uZGRtQvCS2uL2muFh4E33TUT35MpoGwFrpSGHAJybj
 Jun7A/eSrBJo/nOlB9WShA8wUxJm8fkyOR8bH9MDalRW0aShTPWZLMBP6jG7kEvPlknxQvZujtf
 yaVkL+4/BZrx+A==
X-Google-Smtp-Source: AGHT+IErAAydCqqXmAzzYnNnul0P/+1CzhNYVKwJ4skj0qBksVXUhdSQ/Sct1E7k8kfCXZpPj5xwOw==
X-Received: by 2002:a17:90b:2f0e:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2f2e9378343mr6421401a91.28.1734572119450; 
 Wed, 18 Dec 2024 17:35:19 -0800 (PST)
Received: from darkstar (189-71-161-74.user3p.vtal.net.br. [189.71.161.74])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f447798916sm176375a91.11.2024.12.18.17.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 17:35:19 -0800 (PST)
Date: Wed, 18 Dec 2024 22:35:35 -0300
From: Davidson Francis <davidsondfgl@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Davidson Francis <davidsondfgl@gmail.com>
Subject: Ideas to Improve GDB Stub in Qemu for i8086
Message-ID: <20241219013535.GB4298@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=davidsondfgl@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
Some time ago, I wrote a Gist [1] outlining what I believe to be the 
ideal environment for debugging 16-bit code in real mode on Qemu. Based 
on the feedback I've received, I decided to share it here to gather more 
opinions.

It is commonly known that Qemu does not handle real/16-bit mode well with 
GDB. To work around this, there are various hacks available, most of 
which involve GDB scripts to make debugging less painful.

Basically, my idea involves two small and specific changes to the GDB 
stub:
1) Returning the correct CPU mode as "i8086" or "i386" depending on the 
current CPU mode (on x86_gdb_arch_name), instead of always returning 
"i386".

2) Translating segmented memory to linear if in real mode, i.e., 
returning CS*0x10+EIP instead of just EIP, and similarly for ESP, etc.

Originally, I considered submitting a patch directly, but I wanted to get 
your thoughts first. I understand that Bochs and similar tools have 
sufficiently good debuggers, but it would be interesting if Qemu had some 
improvements in this area.

I also acknowledge that my solution might not help in all scenarios, such 
as CPU mode switches, so its effectiveness would be limited.

Ref:
[1]: https://gist.github.com/Theldus/4e1efc07ec13fb84fa10c2f3d054dccd

Kind regards,
Davidson Francis.


