Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7982ACD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZqmH-0006t1-SN; Wed, 17 Jun 2026 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wZqmG-0006ss-Sf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:58:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wZqmF-00019A-AK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:58:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8ULx3239815
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L2MullnKtDvSNEttMvWxOg4No30XVfyLgYfATywVKl8=; b=Da9Y6nJ9qB2X3eA4
 8DG55Q+OP8NrbbpRJDTGjqKp0+QM2n3c5GmL6Dw/haS2QbLmT/Rq48Te208o8h5y
 k95NoY76cyl+e/J3oV3+REwxxTqdAA/94bBwKMQWzB9YN9Kq0Eqaf6X6LEAgAS1o
 5vLKxRXtCnrWbaP0tlwagCAKPdL4cbdrK/YAv6sAIKuhKf6si9okmGxYJsQknLxc
 0l2H8KqfQtJ/fXBF+5huLOkr0TCn5RJ0IfG3uTm0qtH/LjgtkhRa1Srka8mCr0hu
 NUF3rLfmFmlwAtGNoa6RyS9BEGQ9MZlp2VR+4BOUJ9nkiYlywBQJ1memPCqgs0fS
 Q1Hc3Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepkbjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:57:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13980b6561dso7796978c88.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 06:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781704675; cv=none;
 d=google.com; s=arc-20240605;
 b=lfpgvbdt7MB3kutMeodOn+Kta3gB3UKB2amA+kpUW0Ruw6GZ0lUbORW87VuGqLZcDc
 8hKW3z/e3MOJZ74dCenfmy/L65tsEKZF684l/w+2bTNQzMgAEeVZkkvECdqexPSRmGKf
 Gh5uYQZ42JpHAs4YnPaMdq9+MVlLhYnySX7L7xT67YhMw5kBiW5rSojAVgE8R5K0zGg6
 IteJFBl8yAYYom2n3Ryq1m53OxahieKBq5uq8sHgqi8/IkAZ4zB4jWhTJIrGFH8LrDu2
 Nsbl0fV1EaPB+eWmjwxnhxas7zYDDq5Q5YdEq8x7fkzh2pd0blBrs9dpV+TVXSxlkUIP
 KEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L2MullnKtDvSNEttMvWxOg4No30XVfyLgYfATywVKl8=;
 fh=sak5lpIDBrLYUH0yhdqOjB9Q0Pfv8aswHhROIWLKKNs=;
 b=lr0yS9lwUuV4zVzC7CgRJDdGVdaIXKz0kZJKMaMe9bw2dqlT3ugdCJ7U+YIj9bpXHX
 7m3CNwCzQm2ycsrBnOWXfovHNX0HsDp0U68ah+qi9ZoylcsTQcdBMJ0W4g6ZG551Czx0
 U9b7uXUMar0F39iU+jnoD2eFuPPicCYH1UXUCPSV+3+lhzxpjEK2KBREA5zhuR60cEsU
 962bn2w5BjPO0NIvk1KUzgwcT6iklfaj8DYf9a9RPrt5vWKBV93Zx6UxfVlaWzs2gKil
 h6dl0Y5OGDY4JgP/AS+dYq+H/0FEUaW3QQ9yH5Opy5iHtPETHXPBsoIUYNu6eAkaYxw9
 FeTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781704675; x=1782309475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2MullnKtDvSNEttMvWxOg4No30XVfyLgYfATywVKl8=;
 b=Y9JnVGTjGYV4G2UNydI44Fnq+4vDzWsHFb4xa2aZ3A3fujGbZ1gqYTadXPea6wOtnz
 zFmpcbK7011tWOE0pD23hI2KsDMnffaxrLIN7KpHVaLOgDOwtqajkaqEsT7XtT58MEqg
 ICpUDXbfxAKxFLM4dWn2zDcUXEXEUvtFLIA+WoyaYznX9i2r0vfPIdA0iyims/TebD7G
 cg5RkYvZhkYYf0xi+5z8c4WMoEcMMPPTIoU5iok8ep0Ve0mNtpVOd17XkxxjRB9mHSHK
 g7vReIlPXeuPaK40L3RkVJasX1ryJrOLR7eHCuYffWaaJq9PlnLLfaytoCeTHgXyx1Il
 oxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704675; x=1782309475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2MullnKtDvSNEttMvWxOg4No30XVfyLgYfATywVKl8=;
 b=haH9UnIQm/EUEdcgKbEoXz75ciL+pnvRLj49MYJJx4tYV6+pCw/87YkZfUr9UbIrFm
 PuUe/HqsrcZ/oRnwapqk2Wgr1yFJ8EVqbqL3/itxbnbdHYpmwh/+x9ptmzZfXjlptlP2
 GHwu7p6PIDFNmb0thIJScqz/IwDM8Afhhj/x8iKYosH2sNFO3LtrPVYanAXE5OqASi6v
 0QXXGfe94yz8ndWTgW6pzt327MWfx+Ynz9xw1iuGgAZAa0td/9yOws3nMWN3EozT+jTk
 bEvlx+wrBVG2/oa4G4cdxYOvQ4ePUVFZ7LrhiCJ/sWJmQyvru7J6A5qZHDgC5NZX9Ju0
 CcYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fJGlIHRDEbeGvgVfS02SFnrdE069LJXLbJhUb54TKo7e2sx3hsz6q1vRreeYAKweTWurGzrZcC7H7@nongnu.org
X-Gm-Message-State: AOJu0Ywga95PYYg8IY4w828tB41PCX0wx65qtGaVOeBpf3jK/mOkyRRM
 VHgMdC2S9WR7fj7O0mhjV/tpu1U6HJo/1RDKWoLRCq3Z1zglqc8B5NhCVUhHJm8c7AbwGxx0xDR
 /e4X48K64qYKJKLTyUbXz5wWpUtkhrP1QTrMVhz0LG7CssIdIuz9esfT8s2oQHmG8qFMugDG0Mz
 GnHLkhoZkMzbx611CgMOuoxqN1lcBpty3r
X-Gm-Gg: Acq92OFubhgxdrxz7oPlDT1lxExDkMOuLkoPje9b42lHGMbDq7uDkLzwoX7L4qCmcZ3
 AMC2niPbs9CMTEyVGLXPcbeKWvQOojEyAvzjyGsjRewu145q8KoRkIn4PvaJw/zCAZF5hJB7cu8
 lL9+0s3QhPKAyN9QGb/V0G/I2FXVdbvZ4KVNd5FtRD7A5piFq2PBWCGG8oiS/CwOCnsBd1
X-Received: by 2002:a05:7022:4394:b0:136:c24a:7213 with SMTP id
 a92af1059eb24-1398f67b4f4mr1814897c88.11.1781704674901; 
 Wed, 17 Jun 2026 06:57:54 -0700 (PDT)
X-Received: by 2002:a05:7022:4394:b0:136:c24a:7213 with SMTP id
 a92af1059eb24-1398f67b4f4mr1814880c88.11.1781704674418; Wed, 17 Jun 2026
 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
 <5c42a81c-e7a0-47e8-acc9-2be70c8a3380@oss.qualcomm.com>
 <CAEqNhNYSKj4oxYSf6Q9y7LkcvNKD7-5ELxOcVypfEPR81mdbHA@mail.gmail.com>
 <CAAjaMXZvVm9Z3q_UxAoWSWqsgBPverh6o276-wjuCcQDBBmDYA@mail.gmail.com>
In-Reply-To: <CAAjaMXZvVm9Z3q_UxAoWSWqsgBPverh6o276-wjuCcQDBBmDYA@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:57:38 -0500
X-Gm-Features: AVVi8CevJU0exhB11iSv5Q501rqoLOXgNxXLgzC1Gh6fMlM7adXcgHveXkofCss
Message-ID: <CAEqNhNaLRT6C-ddt6AyYdJqw3MApPOFtNMssgKj=sG8AxjwFHg@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Hexagon system emulation - Part 2/3
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a32a7e3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=WWB5BAs865-xiE4xI9gA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jnUvxLxLtgcRsjQ62aEvsnxMk8VxV6pC
X-Proofpoint-ORIG-GUID: jnUvxLxLtgcRsjQ62aEvsnxMk8VxV6pC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzMyBTYWx0ZWRfX07XBWUpCD8Wy
 l0oSRdsM36l5UNkDqUKwKL7dYtc+fDj4rEUdrWuAZK4D0V1FnS6gJ0YlOvCgXQiO2xkZAWgpXkj
 +vgmKTxFr1h53nYIovm/WLoFSptHrtqXAO5u6fVUnP/gGpYSmbqoXAhyjFlwMSgUSphilJjnT8l
 GsQtFawVo03Dck2yEHgXvlHYCN0wxBbnpuLKR/Sq+ghOTxbmTjgSxjrZm//up89ThEaxUEQZ111
 VM80QJk5OqD5SrvWsj2gHdfD/hKDz6+1KWD+217Sv7aim56X56zvoOtisv3wljXjn2vI83NAdc6
 fXl2JQJ8hJn4ptpM9oLOUqk/P9Q+1eI/iXugUcm2txumj8vdDbs9wkuw9sg4K8550ZrJm481APW
 Ky3Buy+SzhlXdcXsFdGdh2NIVAzNWYd7K8CbecMfFMeXZhNo4jnRRvsUbVIK//2mLrjYprnolw7
 D3QCcDbfoAlXd6LNQdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzMyBTYWx0ZWRfX+4oryMztipaX
 pvHzR9EbFf1pVqyD3ZMMpJGc4vd0d9UaeUl8C+PuMWyaWarKzGqJqUEJnnTsrM744ja9360ms/H
 bGiDfo1ayc2mZwUUdmAQHSnxCHC0VEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Wed, Jun 17, 2026 at 12:42=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Wed, Jun 17, 2026 at 7:40=E2=80=AFAM Brian Cain <brian.cain@oss.qualco=
mm.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 7:27=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> > >
> > > On 11/6/26 07:32, Brian Cain wrote:
> > > > This is Part 2 of the hexagon system emulation (sysemu) patch serie=
s,
> > > > building on the infrastructure from Part 1 to implement the runtime
> > > > helpers and CPU operations needed for full-system emulation.
> > >
> > > For some reason this series is missing ordering, but is fully
> > > reviewed AFAICT, so good to go?
> >
> > Yeah - sorry about that - I'll fix the ordering next time.
> >
> > Yes, fully reviewed: just wanted to share the entire series w/rework in=
 context.
> >
> > Only part 1 has unreviewed patches.
> >
>
> Hi Brian,
>
> May I suggest using b4: it allows you to define series dependencies,
> so you can keep the series parts that you don't want to change as
> dependencies and respin only the other ones.

Yeah - that's a good suggestion, thanks.  I've used it for picking
commits and trailers but not 'b4 send' yet.  I'll take a look.

