Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1711CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6ie-0004bB-QO; Tue, 23 Jun 2026 15:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6id-0004ah-C7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:23:35 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6ib-0005mA-6Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:23:35 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c88e3e82d81so68951a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782242611; x=1782847411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHOveFo0KpmseaDViw1qYaFEiRNj1XLSIXaPOVdcL3Q=;
 b=mcao7Gh1kT+Ry/YuSQXoaOuJv/QtDxRj1soCG9DxGTDxA1z14vBxo4jJEPwCE4b6Qc
 DDeT96f6i1eoYmbiZu9W2cWnGOsAwxXaplIJPTOJzr/6sUuz3r1nLhnSaFaUtqL0GrDQ
 6NIrvmK0NPcURElyWA8HYnQSYL60RflX5u6r1Mh6673mE4paYAwL3PqsTHRXdYhDhieT
 028LOdZLIG3lQUEjTkTp8wDe5Zt4t9fHo/GOztu4i/Azkr+5/ubn+Tc7sk//DZQJjOyA
 6VqQVDJKdIgpcDgV7cjgpxzWd5OVi2EK2QT4ie7kZtQgpufgKhZYKiTF8lT0tgM9GJoR
 FIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782242611; x=1782847411;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHOveFo0KpmseaDViw1qYaFEiRNj1XLSIXaPOVdcL3Q=;
 b=I6ihFx0GvoBpjjSXtLsjkP35f0+VP3Tok2S95da/Dta/SFQAX9O7luz41d1ZiX/PA7
 UOqDdkUVOwjDAHh5cAVROgKXWBa+Gr3kfdb9hNBv1be19W2BpWQyjMX5JekboOaTwcvr
 2keSB+V3vq8xCZnEoS3eW6+TJPcBxGshliWUfTLf7bmt97+Twnyd6bcrbKaGfceimLpm
 SwOSmOaNIqGlazWDRYWBe+MRKn1rarWgR504TFIFs4hzEXAHQ+Gr4eoU4HdJyIPcGVwt
 zCW8HKTB+4mo+Q0sT9PdWZCi2REyOH1OwgU4A8d0h9u1P9BJkX3GSGQoHqQXmm47M+qR
 jN/g==
X-Gm-Message-State: AOJu0Yyr4J1yRhPRsNIwubZ99Ql6q9n6IhDj1uRGiGlF+dnC5+fcQQzq
 LyNp/YsoIHANlDJiXptTOn5ubAgqLWJAA/FxXs1COVuED+fukp1QzDJ4nxWp2Vu1tJrLATgvEDn
 /GeJu
X-Gm-Gg: AfdE7ckA30EiwtvTFbN3/uL5i8rdvMWdt8LNmO+B3q4Q28XuhIK7FEe2eXAe5mOxHzp
 Z455435SmXhXYk2N5OO+hPD8ZWSdYfPcOq1Qvi+fmu+n9TqzWEL1SCHo4Z3EXF/RF7VVs0sdevw
 hTpe0dYUVK1xSS9aqJ537h13iiM43KdWJ51IEAu0PUGWkcM8uuN/ZFRLD8Y95vdn9/jsVExxUyc
 LMRsWl9H5X2Uh5a0/2s2vW4Ppb+w3p7SN00yyZW/W/mY/mdbHPxcGcLy+X+pU/9borL56tPrhWW
 f7R/WeWPwY/t+c9FtEfKRwrOU4owbK0eKPeQiDGZyfDC+alVKWGH9Lh83lQl9aOEPV3NA9pyWW5
 ZBrsDXZPG5OnC8L5YGndYbPrSL2XQna/CBrzJnYsbVE8N2KQO1toiCuGv7Bh3wKc04U5VPfvmKu
 MGEwgmc2eoBPjbPwNHii/RCb1ri43YsBtRS1X32O43Sq0ed8h+tfpkL35fvw==
X-Received: by 2002:a05:6a21:6e4a:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3bd2d154791mr103296637.31.1782242611348; 
 Tue, 23 Jun 2026 12:23:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc326c487sm10674995a12.12.2026.06.23.12.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 12:23:30 -0700 (PDT)
Message-ID: <fddffcaa-0d68-4b78-910c-0ddc0ad680a3@linaro.org>
Date: Tue, 23 Jun 2026 12:23:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/40] bsd-user: Upstream most of the remaining system
 calls
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Upstream the file, thread, socket and remaining signal system calls (too
> numerous to list here).
> 
> This series is an ambitous use of claude to help me upstream all the
> remaining system calls. I've batched them together in what I think are
> reasonable chunks, and had claude do the grunt work of copying the code
> over and attributing the commits from our complex branching history. The
> chopping up was a bit arbitrary, but I think it's good. The commit
> messages may be a little weak, but may also be OK. I've also double
> checked the style and made fixes upstream for them as well. Claude also
> reviewed all these changes and found a few bugs that I've fixed. I've
> personally read through them all and haven't found anything glaring. I
> fixed all the bugs that were found, in most cases differently than
> claude's suggestions.
> 
> I've added 'Assisted-by: Claude...' to all these commits to reflect my
> leaning on Claude so hard. This use falls within the 'non-creative' use
> that the Qemu project has said is OK. If that's not the right thing to
> do, I can remove them.
> 
> This leaves sysctl translation, the powerpc architecture support,
> coredumps and a transition to 'truss' based system call tracing. With
> these changes applied we'er down from a high of about 30k lines of diffs
> to only 5k (not counting genereted, but checked in files in blitz). The
> changes are 8k, so maybe a bit ambitious from that perspective as well.
> 
> There's a few lines over 80 that I've not cleaned up. Let me know if
> that's a problem. The other warnings are about adding files, and there's
> no new MAINTAINERS entry needed. And the 'arch dependent defines should
> be avoided' are needed to cope with different FreeBSD build systems
> having different system calls.
> 
> Note, this is called out below too, but in v2 I've folded back all the
> fixes based on some out-of-band feedback I recieved to do this the
> normal way and the qemu project isn't interested in the fixes to fixes.
> 
> Note that in v3 I've added a rather long generated file. I generated it
> automatically looking at the type annocations in FreeBSD on the socket
> options in comments. I had to augment the annotations, so I can't just
> generate it within the build from the installed headers until it's
> merged from head and then merges to stable branches and then waiting for
> a release on each of them (6-9 months given FreeBSD's release schedule).
> Also note: there's a couple left over issues from v2, so if I've not
> taken care of them all, please gently remind me if you think action
> is still needed after my comments before.
> 
> And in v3 I've added some random_seed fixes for fork/new threads
> since we're upstreaming those files. These should be correct now,
> but I'm looking for the correction.
> 
> This is a big experiment, in many ways, for me, so I'm interested in
> whatever feedback you may have to make things better in the future.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---

I browsed through the later syscall patches and nothing seemed off.
So aside from patch 1 & 3,

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

