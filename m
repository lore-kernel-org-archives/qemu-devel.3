Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C704C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOw5T-0003N5-RA; Wed, 03 Jul 2024 05:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw5R-0003EC-9N; Wed, 03 Jul 2024 05:15:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw5P-00088k-7N; Wed, 03 Jul 2024 05:15:37 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDYz84KRQz4x0C;
 Wed,  3 Jul 2024 19:15:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDYz20ffLz4wbr;
 Wed,  3 Jul 2024 19:15:25 +1000 (AEST)
Message-ID: <35adc6fb-5797-4c48-8245-31728a3d5265@kaod.org>
Date: Wed, 3 Jul 2024 11:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/block: m25p80: support quad mode for w25q01jvq
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703081623.2740862-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/3/24 10:16 AM, Jamin Lin wrote:
> According to the w25q01jv datasheet at page 16,
> it is required to set QE bit in "Status Register 2".
> Besides, users are able to utilize "Write Status Register 1(0x01)"
> command to set QE bit in "Status Register 2" and
> utilize "Read Status Register 2(0x35)" command to get the QE bit status.
> 
> To support quad mode for w25q01jvq, update collecting data needed
> 2 bytes for WRSR command in decode_new_cmd function and
> verify QE bit at the second byte of collecting data bit 2
> in complete_collecting_data.
> 
> Update RDCR_EQIO command to set bit 2 of return data
> if quad mode enable in decode_new_cmd.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/block/m25p80.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..9e99107b42 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -416,6 +416,7 @@ typedef enum {
>       /*
>        * Micron: 0x35 - enable QPI
>        * Spansion: 0x35 - read control register
> +     * Winbond: 0x35 - quad enable
>        */
>       RDCR_EQIO = 0x35,
>       RSTQIO = 0xf5,
> @@ -798,6 +799,11 @@ static void complete_collecting_data(Flash *s)
>                   s->four_bytes_address_mode = extract32(s->data[1], 5, 1);
>               }
>               break;
> +        case MAN_WINBOND:
> +            if (s->len > 1) {
> +                s->quad_enable = !!(s->data[1] & 0x02);
> +            }
> +            break;
>           default:
>               break;
>           }
> @@ -1254,6 +1260,10 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>               s->needed_bytes = 2;
>               s->state = STATE_COLLECTING_VAR_LEN_DATA;
>               break;
> +        case MAN_WINBOND:
> +            s->needed_bytes = 2;
> +            s->state = STATE_COLLECTING_VAR_LEN_DATA;
> +            break;
>           default:
>               s->needed_bytes = 1;
>               s->state = STATE_COLLECTING_DATA;
> @@ -1431,6 +1441,12 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           case MAN_MACRONIX:
>               s->quad_enable = true;
>               break;
> +        case MAN_WINBOND:
> +            s->data[0] = (!!s->quad_enable) << 1;
> +            s->pos = 0;
> +            s->len = 1;
> +            s->state = STATE_READING_DATA;
> +            break;
>           default:
>               break;
>           }


