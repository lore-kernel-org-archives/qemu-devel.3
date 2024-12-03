Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F6E64AB9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUZN-0005ck-KC; Tue, 03 Dec 2024 10:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIUZL-0005au-I3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:12:07 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIUZK-0005xx-1X
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:12:07 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71d59d86ba7so2835511a34.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733238723; x=1733843523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F81bm99futpUOdX4dtkdh32tMOL4GbNfIRbbiImbzPk=;
 b=EzGzJyiMVnwgkk4ppRfbzAiP+Uqrf93Bp2THhkwQ4lptY3JW89BUlQJ8ibhc293ZXT
 cFkPF+t/mMWvVa7prH6257GCkDyehXizjWsYdLAGlNfGiVA5H96yraeJknL/jQhbPbUe
 RPm56ZGF4nZ496F78Gl7m8myLASQ4PKDFFScvTxcXi/AI6xMliW1z+HY4OcBDXedb4eP
 7uB9nFBZgogB9f73IwStW8jSaZtbyssocidtU4bkpwMpg17CEyehIVHVUh75IA55TXT3
 kc9RAxpoVrIi/d7IkAuIW6i5PvTqJereBKpe2pkwjPMKDwwwCheNk6cf8UIm5hDm8QmP
 yfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733238723; x=1733843523;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F81bm99futpUOdX4dtkdh32tMOL4GbNfIRbbiImbzPk=;
 b=Sj0orfVXv0qN/p53kzrr6pYPm7eiP1jpl6247eNfr3a4QWLWMiDqdZt9vIc12d0nTL
 679X7H5Ns3oMTT0hhSxuNc4c4sJ/nPuPntbLDzRDZ8hW/GDiKXDwA/sf4UscBUXbtQSX
 zPPCimBnQ7hmLb3opCTm6IgPHvTfbA5EcZlNC/NrrFhjnT7KUb4/LIUU99hdbRigMmUk
 BdCLveC4RBUNcAXXv+VPycFNCpGESHNPdQQkUMzASF5jYziaQRdc2fSgG0yk1ZRJxDb4
 nY8wDIy/xx1nRnSbLO7TXcaSq1ANjulUYJPUDUWGPAouPyw1IDHBiEpEPUBNVzFbFp+U
 y3Xg==
X-Gm-Message-State: AOJu0YyXxod9OiT+yICVPV+mvh2RSKVu2s+bIXa+wiJKEt1hou74U3Q4
 HlA4JSOStxExb6m32ymgwQLOFbcgi/kec9FbFPZ9Eh04bEjik4EEJ1CgtgdBfzA=
X-Gm-Gg: ASbGnct2b3pRWDEB55Ucl4frIhQ+WaWKFNdcrpmnIGJe5llvhlwQZwvXgecM0QAEHAa
 G3cJa1KAUlum2XM4khZbYmEOAJNv1ycXRlybN/BtUaqheJvF8gRDjK6djh3oNITU4vcf3ZyeF70
 Q+nWZkgXao9Hs6ep5ExGE0iTD2xh5ATGltokWOFHJKkgHcIuKi/N+3Rf50v7GV/gd55fWQf5cCk
 wIKwxDZiXQ4ZC9No3doToqhH2Ct+VW6XvURzpkYtW6lTow857ipNwiLAPP05DjwVCYiXFukXXPY
 tUz7jUJ557aexOg0cTWMsapEIIG7
X-Google-Smtp-Source: AGHT+IHFzhKa8AFuakdPijMvJxOHDVXPS1hk10P5e9QIXWp3GTVMiduhfyMBYyqypNpH+DiEk/3Atw==
X-Received: by 2002:a05:6830:6d8a:b0:718:180b:5b3c with SMTP id
 46e09a7af769-71dad6da961mr4457708a34.28.1733238723362; 
 Tue, 03 Dec 2024 07:12:03 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d7fc7sm2822653a34.44.2024.12.03.07.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:12:03 -0800 (PST)
Message-ID: <4a0efa7f-03a1-4532-b1cf-db09d5181d26@linaro.org>
Date: Tue, 3 Dec 2024 09:12:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Gustavo Romero <gustavo.romero@linaro.org>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
 <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
 <6cd6b3fd-8362-4fa8-b6e5-e0e3aded3215@linaro.org>
 <f043b94a-278f-4009-87b9-9b2ba4b80c42@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
In-Reply-To: <f043b94a-278f-4009-87b9-9b2ba4b80c42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/3/24 08:55, Gustavo Romero wrote:
> It's not "really" using kvm acceleration right?
> 
> It's using kvm but the kvm module in the host kernel is actually running
> fully emulated in QEMU system mode (-accel tcg is being passed to it).
> 
> So I understand it's "all TCG" in the end and no HW acceleration is ever used in the tests.

Ehh.. yes and no.

Yes, the system as a whole is running on a host under TCG.

No, the nested guest is itself using KVM interfaces to the guest kernel.  In this case, 
it's what we must to do in order to exercise the FEAT_RME code within TCG.

But contrast this with another scenario in which the nested guest is *also* running under 
TCG.  Double jit translation is, as you might imagine, a bit slow.  But it can be useful 
for smoke testing code running in the outermost guest.


r~

