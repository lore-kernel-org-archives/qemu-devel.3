Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90D4FDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxa5-0000kn-NH; Thu, 23 Apr 2026 13:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxZs-0000jO-GC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:11:00 -0400
Received: from qs-2001a-snip4-8.eps.apple.com ([57.103.87.11]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFxZr-0000jw-1e
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:11:00 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 93AAA18752A7; Thu, 23 Apr 2026 17:10:57 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJA01fDl4fBBdGGVUERx5dVkIeGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVAAFQAXQZGeFV1WQNZH0R7PXFAdl8DRBQ8AF8OLnRAfzsBKXErRx5JClYJXghGEVsUVkNRGQxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776964258; x=1779556258;
 bh=HL1h/PxzAsbYksx2lRRPNSACLWEE9R23VAT67j2+jro=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=f5haz+dJFgu3MtF4k8Y9gZvlpKfszTwh/n/xhlw4e4Kh68HBqnHmPNhn0qOueNm4Dsi5PPw+QtkpAfkZ0X/Aa//lPFpZdFaYUERnO60KTQqRA7l6IM9iGyLOJg195eg6+IeD+QQ/pcLW/U5NkidB6iUN9GHcOsn3Jfo8nG4yHxfj6+Cs27mseZhvclD6vSzhCP0dtrwmoDI7ATJU0b3dB2Rx8sVX4apz1nSjmDSqkdp4AOITWxWBqA0e1ADvy664KLaszzPQJYHSj6u0mvAhcco5UhU7ZJDpWbkQqeCWsNuhzm0OXH5I18zNimmMmSur1IY17SnkIMa2vSZvCX7aKQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 2940C18747F9; Thu, 23 Apr 2026 17:09:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 10/16] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260423170229.64655-11-philmd@linaro.org>
Date: Thu, 23 Apr 2026 19:09:02 +0200
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8397646A-F442-4BEB-A414-D329EF0FC2DF@unpredictable.fr>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-11-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MCBTYWx0ZWRfX73EsA7XU3Y2O
 +aZk7bjoZbU6l0ZVeyc3dkgj23L+eaqBebHog45z6qgk4pjjqeq/BpaHenyn6PPG9ffLLu1AJzp
 RfGGRh0XMhGppV4Dl6r0JUqqTon42d1YTqfIOBymAWeXQN364aQldl4BBbIvNx6QLrIbJ5PLKae
 xlsNAyfe/OMtS+W35Kk+AaAm/YBYUz6SmEc0oGxKBzJVBHbEGj69sWeb+KemAsfR50DWqWVe9Dv
 T8X5HeUq8EtbSS4ayz9MhhWsyIEul0NccbmEQQ2JyLiRdYWrluId6nqkc8/NbalFEghzCLkHKN/
 ukIgcymZ0yWJXntJ5ggIpQZ0QSXBUfGnMUIBzHBDF+s+hz1maB4ZkiFexM7gno=
X-Authority-Info-Out: v=2.4 cv=Dbcaa/tW c=1 sm=1 tr=0 ts=69ea52a1
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=c9H9iVsSBL8j0jD_ca4A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wXGSCDe0c4Df88tLz5Q_EoVJLpRDn_Zd
X-Proofpoint-ORIG-GUID: wXGSCDe0c4Df88tLz5Q_EoVJLpRDn_Zd
Received-SPF: pass client-ip=57.103.87.11;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 23. Apr 2026, at 19:02, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> We should be able to use the 'host' CPU with any hardware accelerator.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> target/arm/arm-qmp-cmds.c | 5 +++--
> target/arm/cpu.c          | 5 +++--
> 2 files changed, 6 insertions(+), 4 deletions(-)
>=20
[=E2=80=A6]
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ccc47c8a9ad..4f98121be0b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1629,8 +1629,9 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
>      * this is the first point where we can report it.
>      */
>     if (cpu->host_cpu_probe_failed) {
> -        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
> -            error_setg(errp, "The 'host' CPU type can only be used =
with KVM, HVF or WHPX");
> +        if (!hwaccel_enabled()) {
> +            error_setg(errp, "The 'host' CPU type can only be used =
with "
> +                             "hardware accelator such =
KVM/HVF/WHPX=E2=80=9D);
accelerator such as

>         } else {
>             error_setg(errp, "Failed to retrieve host CPU features");
>         }
> --=20
> 2.53.0
>=20
>=20


