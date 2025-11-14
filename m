Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1E5CE8D70
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 18:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJyHp-00080i-A2; Fri, 14 Nov 2025 13:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vJyDu-0005EX-DG
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 13:08:38 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vJyDs-0002QV-SF
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 13:08:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so1490065f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763143715; x=1763748515; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sS4TuJHvwYBLjzB7Rskj2B69G0AxkaHlbYXU+VJy9Os=;
 b=Z0l8KUT7gN69+yTDcwjKtO4dmvVtwGoTwPoLEgGFpkH2i8DiNDNP8Nj8Ch4d3N2Hsv
 Ca5OC33eA5auFVhrvDIL6n6c9gb3gHQgdeouIINhiFdNf8nf4YNoMONaxnIFWafRtOwi
 RL4xvFvCbK45/Rvj6r1uTZT5Euw2mw2Ca8Tg48jxlyVU7f5DCjQHxOC47gPsNG13V4za
 EyO0ZlCVa5knkNkj5hhXRFL2BvazQvsdAnwgx8NpCFpr2f9QRyCl/nVZNNEoX7uJKFST
 8GcsQFB/HybjmR8f/Mjc1XiTh83tVDbxpkmc+xfYVEZSCXxubOXh6HUg8PLCuvI3mMsA
 Wdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763143715; x=1763748515;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sS4TuJHvwYBLjzB7Rskj2B69G0AxkaHlbYXU+VJy9Os=;
 b=JoVLuEtiMX4bEblbPSiOCUnczbnN7qKIPn7lIVQvkqk+rObTE5ucmZeZpDGK4wvp/V
 GpqsZ70hH9BO2WNYUUURjvZENdK+iV8tXQuA/OtyC7hSDrYfSFmwKxUhboKw3p3MvM73
 K586CcaLmI6oqtWo5HAQ3+UJfCdfEVm7E6OgsjcH+ZJ/Mcn+tVq9/GZwB37vpdsm/gx+
 i68u47wGITlvAzgNxQ0sZ+900HBVrsELoSN9igiRWX+LAekM5o7t/fTO0wa0MmsDntAM
 19B4OiRAJHeFnVGLi+HT1VRWX9G1l3+GE9vdsym0MTCBhzuPxoj3Carg23cVNUbJ1Uih
 zPVA==
X-Gm-Message-State: AOJu0Yzubl4Ib3AM41orT86gggTXjX+ehOQKBl+rXagvliMACv+uZQzH
 ExMBZ18MQATICaPLLF2i4Kdq1MrI6Tcy3TZ4MqS3V8rprW3sHYuVCRSX
X-Gm-Gg: ASbGncsE3dicyPhUaBgyciGrx5xcvguDsi6vSD+7wO8ZZkczIMRpi21IP0THFNsPOXj
 OKZy0bux4h8WU74ibENAzogYuJoyw4wsCvzWnDjxULF90anwIwQ0FFXgRfjhO408G4svAeXLelT
 ewJxmJ3c8hhpXakR8N6cwMsxcJ0KiDV9SwLho6eDL4YDhFG9svsAKjk0kXigkbRhgyulAV4Czlk
 cb4Q+dUnnrlVT7498ebfV48p6BTTYaKP4sL5rpF9ygwsBMwXXwjtTo9RtG749F22icX2iA1Pe7X
 b9ZF475HcxUXPEwg1p+6COP5pKNIcdD4EE9Oa00N+OAaRRnbb/JjWHUR28XbhELObd+oa8jQiZl
 zDVA8t8Zh0hhIe9kJxzS6x+LV55lGcZ83tU0jevPV4B3Jpz1+gzZYXuevCLWdd80B9uWSVT5W0Z
 gU3A==
X-Google-Smtp-Source: AGHT+IHEY+WbjzagjXKXoew7zeol0tRmdITtP/uCdcYhvbtdf7SDBaENJkwcu5uuzjC8wOcSef/2AQ==
X-Received: by 2002:a05:6000:1786:b0:42b:3dbe:3a54 with SMTP id
 ffacd0b85a97d-42b59367325mr3848589f8f.17.1763143714677; 
 Fri, 14 Nov 2025 10:08:34 -0800 (PST)
Received: from osama ([2c0f:fc89:122:a5d6:f17f:de94:75b3:6be2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b62dsm11346496f8f.24.2025.11.14.10.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:08:34 -0800 (PST)
Date: Fri, 14 Nov 2025 20:08:31 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu_oss@crudebyte.com, groug@kaod.org
Subject: Re: [PATCH] hw/9pfs: Drop unused print_sg helper
Message-ID: <aRdwH98a_k__cDDj@osama>
References: <20251110155424.694664-1-osama.abdelkader@gmail.com>
 <dfbdc47a-6e70-44d6-8e87-eddf5363ff77@linaro.org>
 <3260517.0rzgI7jUu0@silver>
 <6d5fc070-4756-4d58-ad1e-78bdcfe9db90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5fc070-4756-4d58-ad1e-78bdcfe9db90@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Nov 12, 2025 at 02:42:58PM +0100, Philippe Mathieu-Daudé wrote:
> On 12/11/25 13:30, Christian Schoenebeck wrote:
> > On Wednesday, November 12, 2025 8:03:28 AM CET Philippe Mathieu-Daudé wrote:
> > > Hi Osama,
> > > 
> > > On 10/11/25 16:54, Osama Abdelkader wrote:
> > > > Remove the print_sg() debug helper and its always-disabled call sites
> > > > in v9fs_read() and v9fs_write(). The function was only reachable via
> > > > if (0) blocks, so it has been dead code for a long time.
> > > > 
> > > > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > > > ---
> > 
> > TBH low care level for this on my side. It's just passive debug code and the
> > suggested change does not change anything on the resulting binary.
> > 
> > It's not that this debug code is not used at all, but very seldom. Last time I
> > personally used it was like 3 years ago.
> > 
> > > > 
> > > >    hw/9pfs/9p.c | 20 --------------------
> > > >    1 file changed, 20 deletions(-)
> > > > 
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index bc4a016ee3..a8de894f4c 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -1389,20 +1389,6 @@ static int stat_to_v9stat_dotl(V9fsPDU *pdu, const
> > > > struct stat *stbuf,>
> > > >        return stat_to_qid(pdu, stbuf, &v9lstat->qid);
> > > >    }
> > > > 
> > > > -static void print_sg(struct iovec *sg, int cnt)
> > > > -{
> > > > -    int i;
> > > > -
> > > > -    printf("sg[%d]: {", cnt);
> > > > -    for (i = 0; i < cnt; i++) {
> > > > -        if (i) {
> > > > -            printf(", ");
> > > > -        }
> > > > -        printf("(%p, %zd)", sg[i].iov_base, sg[i].iov_len);
> > > > -    }
> > > > -    printf("}\n");
> > > > -}
> > > > -
> > > > 
> > > >    /* Will call this only for path name based fid */
> > > >    static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
> > > >    {
> > > > 
> > > > @@ -2468,9 +2454,6 @@ static void coroutine_fn v9fs_read(void *opaque)
> > > > 
> > > >            do {
> > > >                qemu_iovec_reset(&qiov);
> > > >                qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size -
> > > >                count);
> > > > 
> > > > -            if (0) {
> > > > -                print_sg(qiov.iov, qiov.niov);
> > > 
> > > Alternatively, consider converting to trace event so we can keep
> > > dumping the entries, but select that at runtime (see for conversion
> > > example commit 4847c5701a3 "hw/rtc/mc146818rtc: Convert CMOS_DPRINTF
> > > into trace events").
> > 
> > Probably overkill. We have a bunch of trace events where it makes, especially
> > for investigating issues on 9p protocol level. But this debug code is usually
> > just enabled if you are working on a virtio transport issue or new virtio
> > feature and then you are usually working on this source code already.
> > 
> > But again: no strong opinion about this overall issue whatsoever.
> 
> Fine then!

Thanks for your review.

