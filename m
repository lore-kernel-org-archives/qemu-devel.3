Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC6DC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUt3E-0001sp-EA; Tue, 30 Jan 2024 13:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rUt3C-0001sV-OF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:41:38 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rUt3A-0004OT-5d
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706640085; x=1707244885; i=deller@gmx.de;
 bh=G/0JfyIs0ifaFZC2q1W8aER/zAECBAv7TdIz8kUh7qg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jOHrkXUsLOMXCs4AN01BxMfSijcKbt9BE39SL6B4COXVitikZsKknb/IKlHaL022
 lGaQAySsfaDurLCzQzpQ0Gf28f/TQe7f9aN7TiahGVu+jTCke10f0scV0Qqmwz241
 yigVVPHYr5Md6jyITpwz1RJfRtUDfbNIJ2eedjD5h4jkaWI2bfwqzIJSY5nKovl6l
 yiB9bzibf4jaobseCQ5LsBu31oWhyi3lOTzURNFcDk94hgApggI5BIeMDQCZedAOF
 CeT1yOnVRvpIRwacit8ZtyZ3ImMkkGabAftSAM8eUybqGOW3LegV5UYVth21QAdy6
 +z/l+1OzbF3AT8Wslg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.154.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1rlsT52rZG-00LVfB; Tue, 30
 Jan 2024 19:41:25 +0100
Message-ID: <df925351-b992-4190-acb5-44a7d819e31e@gmx.de>
Date: Tue, 30 Jan 2024 19:41:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add missing decrement of reentrancy
 counter
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org
References: <20240128202214.2644768-1-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240128202214.2644768-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zheD219L+ax5HPRLAZO9m3daP3iw/7svgNkSNXEFn9DuWjOAxOE
 xVkfYwzNHIB+8F7R2P4Q23AcJpGO3jvJSAvgD3+a6PTLQAkV99aCNgz66eXSV78o4cKKHSF
 xwzsETiAFBL8ohHhPDVh3nNpZExdVh3vPJ3whUOkDb/aW+WYQxfW1msLDaYjDFPzL9boczu
 hARj5dEp3OPeWI+I9NspA==
UI-OutboundReport: notjunk:1;M01:P0:nMyr3SFnuUY=;Q4fMJRYUciAnfRApdFLtnCuTyoZ
 85raeRhsxZOLAROqPpxs6eLn1WM+2eD44woyxAXhNFQVRT9iTtxQ91vz77D5wAdVTeAyYwPu6
 Tyc0ZMxYsK7SQy+xIO4649EjKcf9IiRP4bCnMsSAdhPj294zSjhV5ChoJor9PlwTRp9r8XeIk
 2Z8ABZXeuq8rqOvVO9ZThGgeDR5M9vVrywxFkotLxfAjm/GkTTZMtiWpeC885RRrFftHo7WL5
 vXuL52zgpYMS+ak8vWOtywCzPfXmFwFjMktYuogqm//aCzuWeITOLR8aeqnzENnjC+vXlSrfZ
 gvA0i4zBGnWyzPEXlXx4Hjfys3uttYKbcryupGgNRvkCpdPteAssd7R22fqhae0U0Tvf43MdR
 Tf0yI3guUCfpaN5RAWmEfgvgAYd/NzCnC30MeA24bs/CoQAH0n/B2XVNIctNnmsj0f312OlWF
 nopUs1TjdrmIX4h5HCwuD8EqSkQ1XyRoMjGFptB0ctygng73/7+M4EANBuwJTOX0Npu4PvFzu
 9kyz3jkCGbImCW2UkotFFMTbB6OkjXlpkTnrluUJyq3fn8e16ADvYWsUKajbknOWfleUCIjQw
 U1ya1sY4rxTukf3j+njfsjGUsXS04+NDzjXQ8sqE2g0rSKhUJh8FOQLlcJQ2+sLcN9iAudXWo
 SfycfDY6qmmWGWl+fL3e7B9gu1yLM6f7/Un3oN5rLqgESYhb9rBRtpMq4MrU7MfKZQU5keqvN
 0ouACPNATR9l1McJnSGjjGLkE4wBHiwruXnja30MuFkhbl2UM0dWpJqqqN+BlIhsPQXZWogtF
 ObX2gFMM2jX658p9SvNMfoVhqLFYlg65zFVWgoBW938tPCWkM3mIKMHZ0nyyv+AUNpRb/Bj/I
 i0AZ4uvT+MF6azWPGHIx3u3/mVDuCAUGxlEkpHVEVuv4tQBWmpEbIIu5l/U1dQ55c7JvJ98vZ
 6VcPJ6h7Cdkr6SyyFc2mNvq8Ir8=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/24 21:22, Sven Schnelle wrote:
> When the maximum count of SCRIPTS instructions is reached, the code
> stops execution and returns, but fails to decrement the reentrancy
> counter. This effectively renders the SCSI controller unusable
> because on next entry the reentrancy counter is still above the limit.
>
> This bug was seen on HP-UX 10.20 which seems to trigger SCRIPTS
> loops.
>
> Fixes: b987718bbb ("hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI=
 controller (CVE-2023-0330)")
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>   hw/scsi/lsi53c895a.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 34e3b89287..d607a5f9fb 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1159,6 +1159,7 @@ again:
>           lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>           lsi_disconnect(s);
>           trace_lsi_execute_script_stop();
> +        reentrancy_level--;
>           return;
>       }
>       insn =3D read_dword(s, s->dsp);


