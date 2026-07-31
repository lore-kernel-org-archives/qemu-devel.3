Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF1AC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpqMi-0003Ln-Og; Fri, 31 Jul 2026 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpqMa-0003Ks-DT
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:45:38 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpqMY-0006iF-Ik
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:45:35 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-668432fe416so1391023d50.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516333; cv=none;
 d=google.com; s=arc-20260327;
 b=oHNLvnh6RCsHOZP0OY6E8/Bp88JER2S0+0y3QgOIQdSBZuphd1bYBpGSFlxvb5ddMy
 h/xjB9b1pG5A6xVggHMOhizVz1maEPbWUNvjSUAt5yto7zydFQ9YuIgZhwv/SO+VfjhM
 h25kf3qt5R8954nuO4nCc+vygmmyDlesd4/N/pZbY9vAanXIj7HlvSAKaIzNV3y159OR
 4sjl2DvoHMPAKmFOsIM0HsucyBMVmOhwttukHWAmpzB7nFoiFGQ3UisRhUgrsC+TGzg1
 MAlaQvGfu0szv+Dc3JaTKn9kXK3ii27i9xC4CGRI0PVyLJU3VF2IncGBBscTAOCT69Bm
 TLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wYc3wfIbaPEVPTdi9duaQIHDhvUaOqZn1n3L3eHAKTE=;
 fh=Cl1qdbMJi69Nzml0jHfOHf5GnLHYX18FskqlTJAdaH0=;
 b=dbojlxW5Y5A2FxTUg2Wrw9fD15ONVR1zNL8X5LVxFQeEAae2XDnJdOMs4bqYY5L8Pm
 NkR54jO1jTaay/O61ZnXx5LzttlxE/Nh07qf227B3+HT0uHGtmEZMH6zPZe7jf/ITZi/
 ZLJawMTSEc3yTatjxgjQSDXto8EbzJlhBdKQd3c6NamjufU8VdtXtNt3djUaki4shDv8
 LxOywSOsyfckfgDQGJAiQ8oebaxwj81R5Vu9eRM0M1x7kOTUDeZ8kf1E79eds/1sV4+g
 vS0fzymhvjdiu7qgJXEguRLyidtRDhp5S/3IGkRtJU+GITBu1DqzalgBcBsu+6hviWz0
 c6mg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785516333; x=1786121133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wYc3wfIbaPEVPTdi9duaQIHDhvUaOqZn1n3L3eHAKTE=;
 b=Qy6x8OCZOGNLtdw0p0ImPMq2JpfrZYRjeWPI5gxHKgHKEx1Lg1ur+3f719LBANthi8
 LJSrVYh5Kj+YyQy8X3M8jMXegx2M7ph96FlIoWd9jYGe4T+GbXtsIHNp0zgtaNndvSNZ
 7JmrsinWX/Ilt8eUwilFyr4j8E0hUxj7syvBp0dfv+ru44GU1anm0EOfbAtxCC+e9kPO
 R0OSLBZfQf9wHCxcxxYiFS8n+KKBADEEK1IPRJbc4n02t0sGFp3eZN0CvTMKT+Vmatxa
 d9UFD0W7Ed9K2qGTI0hzFa7/GS3SuB4HviDqF07x1W+a9t8mAO99Cl/D0qJ7D/MDc1oD
 dWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516333; x=1786121133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wYc3wfIbaPEVPTdi9duaQIHDhvUaOqZn1n3L3eHAKTE=;
 b=a2n+bc6Bhp4W+vqq46jtahoCqFw8mik6b8kakY4jRqEJWfObVQuqvY4HE429d2tRHF
 lwIjRsokUuclFX58LYdxqWe9u+VB/DTlJMMHQkwWYFiZeNAImJGh7oH5x2wLdMd/IeRe
 bCxoQiw1KUiKX04gIQV9z3RVzBULKOMderDZFHKJLk6GO26Jk4lLOvLUXfkNPXkrQSza
 qRpeykA8tsA9bfs3mw0gsz43MNb1I+CeqaY13K0Op08cQ5lufvcCt0CVF8XNFrC5au0g
 V+dlH5jFHkeIwoYfvplN4bOli6kqGXiSKQsOgji7ix639uUpnPNFOVXfJc4taOFOwGyc
 p6BQ==
X-Gm-Message-State: AOJu0YwJuZhqaO1l08OhaQhFV+WNiEEDZ+dcPrPj+gRb6OffCExlrgba
 l/nk+wEaxmzWInXL58iWmB2mOYbuJ30BE1w6UjOMcANebzhau6D2AhqQIGirQWySLSNHfw2BD3H
 JvTV2nwPnyprT3OhbcyLZma89/1VmBJY=
X-Gm-Gg: AR+sD11eokin/wWqYYUJrM4IUcgcYWrrRPa2cx7FEtgsRlTAOMOApviIo9mOesgmTUJ
 5xdJ3j4xjTkE85luzx12Quyw6s3yeqZqsSX9CLMkJrjusRtxRGLw+mMv5svoF4QoVRyDRTszcsg
 cnAOtlGBxSNlCiwUnR6+5SFEDOicBfrtxkChQDiGjaLRL+nze7QqarEaryNpMR482FdwY/aGiYo
 M0Zc3nS4f6Zqjl0iyzKkTAPg0JkTpI09xhkE3AJGYBLwJBRukVrZ6svjpOwmJ8DHdDB84/zTCf6
 TRw3hZUi5M4Jm2pCUpNBSWn4pFSV9WfXE8na4+jg0q1LbeA=
X-Received: by 2002:a53:a286:0:b0:664:9736:424d with SMTP id
 956f58d0204a3-6694f2311b9mr777231d50.48.1785516332942; Fri, 31 Jul 2026
 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
 <20260731093618.2961031-3-peter.maydell@linaro.org>
In-Reply-To: <20260731093618.2961031-3-peter.maydell@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 1 Aug 2026 00:45:20 +0800
X-Gm-Features: AUfX_mz0715DY8a6Juscg-DPC85d26eXheXj0xofXYZCpADTfXgyMLpcLogXhY4
Message-ID: <CAEUhbmWx8mdX5xJ=O4620onXk4-HoOR=jULVcfYfRom-SF+dow@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/net/rtl8139: Send whole of vlan-tagged packet when
 doing loopback
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12c.google.com
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

On Fri, Jul 31, 2026 at 5:36=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In rtl8139_transfer_frame(), if we are transmitting a frame over
> loopback then we do this by calling qemu_receive_packet().  If we
> have an iovec rather than a simple buffer (which happens only when
> we're sending a packet where we are inserting a vlan tag), we have to
> convert this into a simple buffer first using iov_to_buf().  However,
> when we do this we forget to also update the 'size' local variable to
> the size of the new simple buffer, so we will truncate the packet by
> 4 bytes (the size of the vlan tag).
>
> Correct the logic so we don't truncate vlan-tagged packets when
> sending them over loopback.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/rtl8139.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

