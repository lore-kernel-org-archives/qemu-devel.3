Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427D3F54ADC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54zw-0002SJ-Ew; Tue, 24 Mar 2026 12:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w54zs-0002RI-Ad
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:52:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w54zq-0007bc-Id
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:52:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OGKweB3039733
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 16:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6HziRqdtNMNNDx7LyURzpMEacQ1+82Whh1fOaLMXRPs=; b=memiUr6ApQnp1SRi
 9eyotm0qTkSReJCg9N/NVAHjQr9WNzz4KeaLJXNs41CoVpI6HfLlYBckviVKC6fS
 CwacRiXSWna3dK2UXsQLpTMiXfLn7RKSIaG8yaU6QbUQl+Dyg82TF8x2iFoAJDwb
 VHDWzuQZkgXmW6kj5AThWpVUCEkhWyj+6LKrWvo+3oq7Lwzo4vcZtfh/dF6VQT0V
 zRAtcGMqflkc9ofAjkJUrDkCd06wsm8JaVKeKLCH6duGtV5CSXUz1CPZKpHIgKjI
 9wxSxRm2tKLxKcyPJs2AEF8AkQ78rZrI9MJJH1/vEKHY0FADQbhml8I6nUe8Tj8E
 7sPBoQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0hke3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 16:52:46 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-467ec73eec1so21618857b6e.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 09:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774371166; cv=none;
 d=google.com; s=arc-20240605;
 b=kKBJy7Bqy4uJNHkH9gSDfOAYI4IcBZ9UgD24p8GsvI4/DGkT9WJf0oTF8hlfTX7gVO
 MocLUmUBq8kmvMedfnRn2bO0psa+LALhCWSvQcwTi75QNxVhxHHo2anOmHEHlT8V4boE
 GtDMCoeJpNEj0/00PLHx+nIMpqzWhprcIcG02j++w+zD5PH8yz7mBUNxiAcFCzWTVaW7
 ML2I8hjzQ+Bl+85Tq0E0U+ye7X0aoo423qrv79Da3eEdqHd094JccvEcHpyabJ1Vfafg
 aGbKhlQqZihbYbu7qwudIx0DgzFYDVkUKjJ36cT35BcoiLiE9QLQlMCZL+JPWT2SMd22
 n7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6HziRqdtNMNNDx7LyURzpMEacQ1+82Whh1fOaLMXRPs=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=LfW8dxejfykvVxJIizrbC5MP4fXj1iNj4/A1Ls15k6XqiJHZ9Z3IqQz1ica28EvBtS
 goR+wL/RSUKljzFyObQyS9JmS82bYyRt57t2uCtIXfYhlcOZRmaRWXINXa4u6/P+msl1
 tsquJClPsZ918mpUuMu3DCGQt47UcUN1A4RTDuFgjdtBLfsvLGr+BXeFdnDhbbhGRekp
 2cpiOxjNxts7kKdiBUSloQjlHmm7Xi2PefB3p3xViCIZDBd9DWKqYvd+AFB5RbLdEoCf
 xQXeIpKQRXqrm/+Vtp5kMiOlV+aSxtn/hHXzAod61n1wsJrSjv1Mtu1gOqeE3+qYAWdS
 zQ2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774371166; x=1774975966; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HziRqdtNMNNDx7LyURzpMEacQ1+82Whh1fOaLMXRPs=;
 b=JtVBqCvtXGEYU3UXwzgivmXBapfMeHWDrTmAaM1Sqay1sjUrHERN+kRikYLDoAKalo
 HgAJ17+WtuF7pyaD0etBoDRvKV8WYoWQrK3/vsMxOxUFKgSUVSvpbp8SpUyOKXifb+lp
 3c3s7HKOD+BsB5R/dsoPhF89ScRdS/L0oH62Lz/rgJsdr7IimaBBB7CcKKyoMsNZiyIY
 zVqzLjrLoirfcQv09Mxi9J8EAAEzaKqcyaP49gXyBSfUYuded+gtCWWfvdGAzPz22xjx
 PU4OKppSfNNRsXlMJ30ne3/xJWxOxji7EzvbsQs6JZ4QGq/Yn9LnkUrF/1Z2nq/+HwKc
 eRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371166; x=1774975966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HziRqdtNMNNDx7LyURzpMEacQ1+82Whh1fOaLMXRPs=;
 b=Mx46LNeQ7EXIT+Ss6E41FDrxGe4n2FHS6gpuEHDSQBOOsNcp3RcjdfYKDuogiOm4kU
 YkFBkVt8VpA5i0YaGqxjPa0yaPrJc80KVnupMNtPK0h68COPjn2RH6Kw+0X4rFk1iJby
 QBNy+/Pj2JzUFG5uRgq6t3Yvtd3ffct/Rk09wffCz0EqIYsTGt7OohxLnARgwtKrH0qP
 KofVoid+s6T/zoTnv92nksgi2bubLv8Sj21Ree2Gud27uoJx9719UQoTgBHtL3Y4Zym8
 2ajrSPALxvveryQ3R6m9UbG0mCljVWmE6J2ZWi3G1+eOty4p/EZ5Xr+xnfTPfaLLWwGB
 8WHw==
X-Gm-Message-State: AOJu0YxaD7u+f9eAmycx2JMdnH3jyUSKmQwup6z5EfoHEacYNsTfCkco
 YKusUXBcsiu2miSGpl1jMD7tAHiTgjiTJBLFjZzUpY2TJnxmuHnKvxu7UFMuZ6BAuOD2777dfLj
 0mCxqqERsos8HEEgbh5e6NTbIOsVxKYay4slSHSaZE2hRu0w+MhWf7UeULMZyHEy2IK7UwcjAYA
 wGPnIKpozwdPHcSSMzapg/9h5cq6wyw6AD
X-Gm-Gg: ATEYQzyspGb62N+s+mc+fHBqIkf/EwYBjwHApwS095Loo5vAzbn/zsQftRHOIIA33/D
 RrWeMOH87yRz2idNPUTw2eDBpJQN7j69ophWftguKSHrjZpnuxx0fVqQTpuPotyQCuckeljZr2r
 j1AlEdRWQUhwzSCnm0q0LCmr3yRbGf+1nZF8NGcteCvh9qZCFiMDVIsnpAXGRoM8lh73c8yR1M5
 hmV3vo=
X-Received: by 2002:a05:6808:4fcb:b0:467:db5:8b21 with SMTP id
 5614622812f47-46a5c3d6cf4mr165375b6e.0.1774371165916; 
 Tue, 24 Mar 2026 09:52:45 -0700 (PDT)
X-Received: by 2002:a05:6808:4fcb:b0:467:db5:8b21 with SMTP id
 5614622812f47-46a5c3d6cf4mr165351b6e.0.1774371165464; Tue, 24 Mar 2026
 09:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
In-Reply-To: <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 13:52:32 -0300
X-Gm-Features: AQROBzB1FVyWW6-rt13x8khaT-1g1a9t43hHZpaWUfWPCxjlR8bTPhlzCLP71Hw
Message-ID: <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzMSBTYWx0ZWRfX9h1ppcwXoFHg
 vFJZlJilqwYlbMKhOoFjmanVfB1nt/XOfJp40NLUwk1iiLjzfw6b5cdW0hruJK3aVOSxN/KbQCi
 LxDtRvHHy/9GqDQ9Fj5X+MBeUxLYXLwnYQY8o1PPq9evUM5V2A4K/qcG2NSQ+MR4iAPB5mMjekh
 9lsiORKm7n/KVr3o0gW23IK+jCBWf7zSCmXu20HCIVxj2XStvFaX32CYvvlMyYaDAAhZw5LygnD
 gvlkpwzzWqKvyyoxS1rAPFEYnl2tugXitVOA/dSFvRq7vkFAg8qQu4ySnN/auFXMNMUyZU9uje8
 mQRLBA6ryGVHXJpHptGUjwHxGkvbne+pLR1yJHGZH7LKzluiFYcStW9ctpE/l1+EqG92TcOg64A
 tYAmtIIMLb2dVjGX8sKVRnEmpI5tjRYjl6wPwBgk0iprmVxFYkft1o5E8dTRXx1/YX6Rvia5fTR
 wfXyFg9N7AitPcbTSTg==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c2c15e cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=aqt7E0AF0lIwVVJQHr8A:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: UQK_3sld55wXBjfEfqP-bHcB7EQfG6vh
X-Proofpoint-GUID: UQK_3sld55wXBjfEfqP-bHcB7EQfG6vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> This flag will be used to control the HVX IEEE float instructions, which
>> are only available at some Hexagon cores. When unavailable, the
>> instruction is essentially treated as a no-op.
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/cpu.h             |  1 +
>>  target/hexagon/translate.h       |  1 +
>>  target/hexagon/attribs_def.h.inc |  3 +++
>>  target/hexagon/cpu.c             |  1 +
>>  target/hexagon/decode.c          | 22 ++++++++++++++++++++++
>>  target/hexagon/translate.c       |  1 +
>>  6 files changed, 29 insertions(+)
>>
>>
>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>> index dbc9c630e8..d832a64a17 100644
>> --- a/target/hexagon/decode.c
>> +++ b/target/hexagon/decode.c
>> @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
>>      return !bitmap_empty(conflict, 32);
>>  }
>>
>> +static void convert_to_nop(Insn *insn)
>> +{
>> +    bool is_endloop =3D insn->is_endloop;
>> +    memset(insn, 0, sizeof(*insn));
>> +    insn->opcode =3D A2_nop;
>> +    insn->new_read_idx =3D -1;
>> +    insn->dest_idx =3D -1;
>> +    insn->generate =3D opcode_genptr[insn->opcode];
>> +    insn->iclass =3D 0b111;
>> +    insn->is_endloop =3D is_endloop;
>> +}
>> +
>>  /*
>>   * decode_packet
>>   * Decodes packet with given words
>> @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_words,=
 const uint32_t *words,
>>          /* Ran out of words! */
>>          return 0;
>>      }
>> +
>> +    /* Disable HVX IEEE instruction if extension is disabled. */
>> +    if (!ctx->ieee_fp_extension) {
>> +        for (i =3D 0; i < num_insns; i++) {
>> +            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
>> +                convert_to_nop(&pkt->insn[i]);
>> +            }
>> +        }
>> +    }
>> +
>
>
> Better to leave the instruction alone and turn it into a nop by not gener=
ating any TCG.
>
> That way, the disassembly (-d in_asm) will still show what's actually in =
the binary.  You could add the check in gen_tcg_funcs.py.
>
> You could also consider adding some sort of marker in the disassembly to =
indicate that the flag is needed for the instruction to do anything.

Ah, good idea. Will do both for the next round, thanks.

