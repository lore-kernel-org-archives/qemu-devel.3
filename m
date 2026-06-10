Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3377CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHLe-0007GC-LT; Wed, 10 Jun 2026 07:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHLc-0007Fn-Qv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:43:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHLa-0001lZ-W6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:43:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNIK91501046
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bc1TPyygunbOYXif/U4gb+09aQeRwdZ4Mx57g4ynDRs=; b=kRmRjaPEBcwClzIN
 f/uNpDQ7ekJRlTGAyaF9WKKnAsmGK9wRIcLAdFMS9EqkZ4ipGUX8VgZNM3UgtSaU
 38fnN7Qa9XqnNOOORdnwcOCnpcAjmPFIXHZXFARIMLYW+RJMcoLqr6yDwqo7ejvf
 +F4J2/xmKQrXVtkHMS0Isy8BNdFxbAscXoZoz9n4wj3B2AGW2OP5nDH0GmGddMlc
 WVMCv24SIUELBq3J9d6POfl871Myj6mO3ZmXezcny/gBUOHUj/f5i4tx5A+y0d+T
 Uem+yO7P5tRudy/wrymRTB7vVGXQadLSmT1fNFcdX10rfzvFTYE2+kAgOr7qRHr4
 n6XJbw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a9ktd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:43:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5177b8df670so112843631cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781091828; x=1781696628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bc1TPyygunbOYXif/U4gb+09aQeRwdZ4Mx57g4ynDRs=;
 b=VQjpb24hXKXyqRHR77vZG6tFvUir/QUBQTjs/fJmIIcIBsDmk7EcNJkToI+ai1plLw
 0wGtcX2DLcvsiA2kHHigfcgnK9QaKXWedJPvohSBQdSuRy4odNDstmuHq/9Wx6H1N0AM
 f66Qxu35y4/f9BMV/zQjtwD+rOaGTfyCV4zcadCCnKN8iPQTsNv1DptQ/S1q8a6oFJe8
 nROMyxuonaQlNTwD3xwaImiS2PHgfS222BkLbgaAPW5fhrMLERnHBiIbfOdSHN9KRFij
 VibIP63TaHnbSZKJYepABA+9MUCVvZHDXuAieFU+4zeAUZRCNYT0D7f7k7RJ83ijHc8g
 jNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091828; x=1781696628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bc1TPyygunbOYXif/U4gb+09aQeRwdZ4Mx57g4ynDRs=;
 b=B8MefEz+olESwhO7SMn+MKd7JFUwuB5pcIzc0XLMGR6NM3bZpgDgJV1F1Kmcf3qaU8
 4Pn+M/MWib6lclrrBHSgvVeFLQjI/6NcAwFAyCOwO53n1MaKuhB1Pzy6WyTB6WFBOT8K
 j9N9Yw9bCcrBXIb3ECKl5lZepIDWxwCHywSe4z7q1M8Q4P2wdznTTOQOQQXmQ92nbC9l
 bOPu/s9bXE32SfGYlzYkht4BdOipcOAT1CeMzBcUWo8GQbwjBQjBniCq81NJbXgMEyGT
 FhPIybgYlwJUDnsA4fKmvh0JGk2xX9xBGBxcNSBJt1Da5yY4ZWp+w6SHrCxDNBszd4lH
 FRtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nOWwOu1w92D/09VzWNqlNSaGGqtHsA73vY/k+6fpgcgzB+A4rmuX059Pyk9Lx/5Upag90OOweaylO@nongnu.org
X-Gm-Message-State: AOJu0YwjUr7cHgBHBHSEkbvBjfaswDBSKNSokHgHm7xNVaXUXCvjwbM3
 IfBex8dwRCSRJyVgNNA37uIJkU28gUrfA2VTRZPVTZO4FpYnOF/SaMG4ciYt/yRP8LQVhU09YkY
 7pEcjwK8zKliqrTWXV+g5KLcify2REzTSU/2Cy9EgCX4LWrzREiwk1O/Arw==
X-Gm-Gg: Acq92OFaDHO/vD6GD/gDAymcJeKzmd95WL4lxC1FOjj7Clq/IP2iI1cGWJsHq+bDlcu
 Sle397yZiICUNG1yZ9kKHhGhcv4WaXtuM6XZ3rnO2CHt6nXVH2R+MHN3Pfnf42RtXy/nvpr8LGX
 jxF+4aYAl8fzOpTzjwdQtjf7FYL4/A+7bnxt+PYQBaRqorVpOIrBrYFRtcy3bDlfZCyI7I/3PXd
 OvR5mFTWjWUldQ0dsMRgYSia2DKtoDu6r7qwYTPOjWVnRltjXp7y/V9l7VSGoUCB9rdDUC/wz5T
 9Kq4lKo606cOLFgy1xXZw/kK5LLGR6UR8wei7iG5u0fmyM5oTNpG2Oyh8ymraMTDNRsgB4P6XQy
 ySYKxEekc4OudvsTD6HHfV8cDjZWSbcMyrAhCw3Q0t3avPTa2vUBRunXF4XJSPBYVyrf5mkfovG
 rknN0=
X-Received: by 2002:a05:622a:1a8f:b0:517:8aa7:4ab0 with SMTP id
 d75a77b69052e-51795afe8dfmr370472981cf.38.1781091828609; 
 Wed, 10 Jun 2026 04:43:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8f:b0:517:8aa7:4ab0 with SMTP id
 d75a77b69052e-51795afe8dfmr370472611cf.38.1781091828203; 
 Wed, 10 Jun 2026 04:43:48 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64303892sm9815054a12.0.2026.06.10.04.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:43:46 -0700 (PDT)
Message-ID: <4d35d2d9-5770-4d90-aa5c-f8f9c8884ecc@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/22] ui/input: add LED state tracking to
 QemuInputHandlerState
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-9-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a294df5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: DVGIiM-l7ydGUu8bbzEkgMMPJSJ2B3Or
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfXwSx3ePstB5dS
 8QV36tg5m1cgwyBoCSaORAAM7KqoY/bC2bniGeZc1Qe8jIGnll8KoEZOJ2xWO0dJEDMAHk/DgjJ
 xgaG3KI/bcLNu0/SQ5iZCKs/YwKjqebv4pqHQDn4M0HR4fhHgBNOMw/8r0NZYmJDZuuwoL3NFz9
 mo+YNXF//jJSjwnjRjYYV3xvX67PJ6BbWLvp5BVW6VyaEouUBE1GDdUrkuz3VpvuaFoFfvUaH0F
 Uu7g1wOeusSGhRik1yNeOB+zxNscp/6YynHEIVCzRmw1uOjm04kCRjGooCvXBzacCCJZfScMRKO
 R2zP5q+tXl342W8YOY12y8P8KBdDpbv+619xmA9tj2LtHrRw3k/gn9FR30tbGIjYl0s0uMIdubm
 Xc8jaRVRSgPRCyBWGpnpLdipmBe05S7S7Ky+Y7jNijnczEzI5FhUg4S70o4p2NcXYhfZBr2T8hb
 Hmnk/C5NzJpGqjg7FZg==
X-Proofpoint-GUID: DVGIiM-l7ydGUu8bbzEkgMMPJSJ2B3Or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100112
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Add per-handler LED state and a NotifierList for UI backends to
> subscribe to LED changes.
> 
> Devices call qemu_input_handler_set_led() to store their LED state and
> notify backends. Notify also on focus change, or list update.
> 
> Note: I considered conflating mouse-mode & led-state changes, but those
> are quite different events (from different source kinds etc) and we may
> want to improve the internal implementation.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/input.h |  5 +++++
>   ui/input.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/include/ui/input.h b/include/ui/input.h
> index 6df8ae3a8a3..66e5c1f4b06 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -151,4 +151,9 @@ extern const guint16 qemu_input_map_xorgxwin_to_linux[];
>   extern const guint qemu_input_map_osx_to_linux_len;
>   extern const guint16 qemu_input_map_osx_to_linux[];
>   
> +void qemu_input_handler_set_led(QemuInputHandlerState *s, int ledstate);
> +void qemu_input_led_notifier_add(Notifier *n);
> +void qemu_input_led_notifier_remove(Notifier *n);
> +int qemu_input_get_led(QemuConsole *con);
> +
>   #endif /* INPUT_H */
> diff --git a/ui/input.c b/ui/input.c
> index 15affeabf44..99a1090f8c3 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -14,6 +14,7 @@ struct QemuInputHandlerState {
>       int               id;
>       int               events;
>       QemuConsole       *con;
> +    int               ledstate;

In "hw/misc/led.h" we use 'bool is_emitting' which is clearer IMHO.

Now looking at kbd_put_ledstate(), 'int ledstate' is actually a bitmask
of:

     /* identical to the ps/2 keyboard bits */
     #define QEMU_SCROLL_LOCK_LED (1 << 0)
     #define QEMU_NUM_LOCK_LED    (1 << 1)
     #define QEMU_CAPS_LOCK_LED   (1 << 2)

Maybe rename as 'unsigned qemu_leds_bitmask' or 'uint32_t leds_bitmask'
or simply ledsmask? (notify_input_changed below uses uint32_t).

And:

   qemu_input_handler_set_led() -> qemu_input_handler_set_leds_mask(u32)
   int qemu_input_get_led() -> uint32_t qemu_input_get_leds_mask(const)

>       QTAILQ_ENTRY(QemuInputHandlerState) node;
>   };
>   
> @@ -38,6 +39,8 @@ static QTAILQ_HEAD(, QemuInputHandlerState) handlers =
>       QTAILQ_HEAD_INITIALIZER(handlers);
>   static NotifierList mouse_mode_notifiers =
>       NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
> +static NotifierList led_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(led_notifiers);

leds_notifiers (plural)

With the changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

