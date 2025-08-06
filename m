Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF721C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujfoY-0007J4-07; Wed, 06 Aug 2025 11:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujfbA-0002OX-1d
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujfb8-0004Nl-0i
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754492311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=17OZGkdOb1+4Aay+EynVTSgTjGB4aixGfzzn4w00o+4=;
 b=dCwI2+9wSfjsmy0kZ4CYQPSpl4UtpbMHNhMi/qYYRcpdfAWuRiCahAG8adn4KO0/A5fY7h
 Z7trhIERPpsSmr0pTbFCGe6aXqyFuUAxCdmFuVtv3frismQvPJlV14XjrAB3rGMbM0n/LY
 F14tmIUMdbliAmxi0+Yw1OlXMTAMqu8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-y7UsBLOHNYeKV9dvN9c5Lw-1; Wed, 06 Aug 2025 10:58:30 -0400
X-MC-Unique: y7UsBLOHNYeKV9dvN9c5Lw-1
X-Mimecast-MFC-AGG-ID: y7UsBLOHNYeKV9dvN9c5Lw_1754492309
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so38225405e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492309; x=1755097109;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17OZGkdOb1+4Aay+EynVTSgTjGB4aixGfzzn4w00o+4=;
 b=Fi9q40tAT3XpNK9ZESPtR5CiEyYD1JOFKi04X7c7Ibcuaxm1MPbz5riV2C4t2tB5Ah
 gevLcdk6o5keO1EfHboIHGKMd6z5onQdzcC2go0SKluG1CQSxfqHNnNqv5qOuUnLu/VG
 tfqS3SlswsGsXyLEceBpTF8SUArWxAqa2LZs5kZGIW1XA7jh1pWKjfvVZIfftQCXUNUo
 HglTxXIaVRW2V/7vwCzr6v2yndvJ52jDs/EGB8GKUZuN7NWic9E9VSXJQS7VnPT3fV3L
 pFySYiMgn3s5W/QvZ9ZAvb5a/B7rcPKzVMuxbevzOpTCHMBpT1JcIwqOpHhqTxime9wz
 ZWeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs/cJjVlemL1YYbGMH67EevXC2Qhozv0SCobrsVKGufwfQd0D+j55xMEzzT5tkCuZxNI+aFCcgXVZm@nongnu.org
X-Gm-Message-State: AOJu0YzsXLrprytva1cLAlYyRYczxBIiH5qFofkhpJeP8wktx1ghfeb1
 H9TU98cYWSPUlwyGe8qRB2BTxvgIqqfDDcD2tLgp8FKHYx0bR+/DQmiGWBrjI53auAzBQl2aoT5
 4flamK/TakIjt7AQVm37WiFMnJm9gBIvJaJaRbcHj1XHZ7Rwmv+UIlf1o
X-Gm-Gg: ASbGnct/pzbMrwkuf+QPWQUyJHVSy6d/6Jc/rnz5aljoIHxh2FwD67almImNEU4oDKT
 /psRsUHTI7PDWpDtF29N4Bv0A+fdZxYwEt/kHw7Pp81ZNVTKB5lIfRNuvEakTpN+ZMJByOOg6mM
 y7AJYpnHJQEsQ/ahxwaJPFS7mL0j1WXaXq53y3Gp+7GhKDOYp4PoDyA9qmmzcgMCmeP9HFyRBDL
 U06q04LXXflVmbW3Wm8Ccti4nBZj7E1QhB8hq4e+lRjB+L5vC9NnLC+PKBrOJ1/fOrg0A6Xsv8I
 bOuCy+jmqBKrp0oGrApJyQc8ielHYbmrx9Dxa5ELLtzk
X-Received: by 2002:a05:6000:18af:b0:3b7:879c:c15c with SMTP id
 ffacd0b85a97d-3b8f41b5233mr2768682f8f.47.1754492308767; 
 Wed, 06 Aug 2025 07:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDlr+MJ4k2cNprd/wBoyQgrBSZTCPoxifxnKMcWUX4hNVLsWZVZOH7V8Q/G0vHgPeRLM9Kdg==
X-Received: by 2002:a05:6000:18af:b0:3b7:879c:c15c with SMTP id
 ffacd0b85a97d-3b8f41b5233mr2768652f8f.47.1754492308204; 
 Wed, 06 Aug 2025 07:58:28 -0700 (PDT)
Received: from [192.168.10.27] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-459e5862be7sm57185735e9.15.2025.08.06.07.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 07:58:27 -0700 (PDT)
Message-ID: <24abd83e-aa9e-4f02-b391-178249e9bdf5@redhat.com>
Date: Wed, 6 Aug 2025 16:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tracetool: add test suite for tracetool with
 reference output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250806102440.702545-1-berrange@redhat.com>
 <20250806102440.702545-6-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20250806102440.702545-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/6/25 12:24, Daniel P. Berrangé wrote:
> +#line 48 "../../../../../../../../dev/stdout"

These line directives depend on the name of the QEMU build directory...

> +    args += [events,
> +             "/dev/stdout"]

... because you're using an absolute path here.

Maybe you can use a temporary directory, in which you copy the source 
file as well?

Paolo

> +    actual = check_output(args)
> +
> +    if os.getenv("QEMU_TEST_REGENERATE", False):
> +        print(f"# regenerate {filename}")
> +        with open(filename, "wb") as fh:
> +            fh.write(actual)
> +
> +    with open(filename, "rb") as fh:
> +        expect = fh.read()
> +
> +    assert(expect == actual)
> +
> +def test_tracetool(tracetool, events, backend):
> +    fail = False
> +    scenarios = len(get_formats(backend))
> +
> +    print(f"1..{scenarios}")
> +
> +    num = 1
> +    for fmt in get_formats(backend):
> +        status = "not ok"
> +        hint = ""
> +        try:
> +            test_tracetool_one(tracetool, events, backend, fmt)
> +            status = "ok"
> +        except Exception as e:
> +            print(f"# {e}")
> +            fail = True
> +            hint = " (set QEMU_TEST_REGENERATE=1 to recreate reference " + \
> +                "output if tracetool generator was intentionally changed)"
> +        finally:
> +            print(f"{status} {num} - {backend}.{fmt}{hint}")
> +
> +    return fail
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) != 4:
> +        argv0 = sys.argv[0]
> +        print("syntax: {argv0} TRACE-TOOL TRACE-EVENTS BACKEND", file=sys.stderr)
> +        sys.exit(1)
> +
> +    fail = test_tracetool(sys.argv[1], sys.argv[2], sys.argv[3])
> +    if fail:
> +        sys.exit(1)
> +    sys.exit(0)
> diff --git a/tests/tracetool/ust.c b/tests/tracetool/ust.c
> new file mode 100644
> index 0000000000..9f862fa14d
> --- /dev/null
> +++ b/tests/tracetool/ust.c
> @@ -0,0 +1,32 @@
> +/* This file is autogenerated by tracetool, do not edit. */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "trace-testsuite.h"
> +
> +uint16_t _TRACE_TEST_BLAH_DSTATE;
> +uint16_t _TRACE_TEST_WIBBLE_DSTATE;
> +TraceEvent _TRACE_TEST_BLAH_EVENT = {
> +    .id = 0,
> +    .name = "test_blah",
> +    .sstate = TRACE_TEST_BLAH_ENABLED,
> +    .dstate = &_TRACE_TEST_BLAH_DSTATE
> +};
> +TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
> +    .id = 0,
> +    .name = "test_wibble",
> +    .sstate = TRACE_TEST_WIBBLE_ENABLED,
> +    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
> +};
> +TraceEvent *testsuite_trace_events[] = {
> +    &_TRACE_TEST_BLAH_EVENT,
> +    &_TRACE_TEST_WIBBLE_EVENT,
> +  NULL,
> +};
> +
> +static void trace_testsuite_register_events(void)
> +{
> +    trace_event_register_group(testsuite_trace_events);
> +}
> +trace_init(trace_testsuite_register_events)
> diff --git a/tests/tracetool/ust.h b/tests/tracetool/ust.h
> new file mode 100644
> index 0000000000..1184ddd870
> --- /dev/null
> +++ b/tests/tracetool/ust.h
> @@ -0,0 +1,55 @@
> +/* This file is autogenerated by tracetool, do not edit. */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
> +#define TRACE_TESTSUITE_GENERATED_TRACERS_H
> +
> +#include "trace/control.h"
> +
> +extern TraceEvent _TRACE_TEST_BLAH_EVENT;
> +extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
> +extern uint16_t _TRACE_TEST_BLAH_DSTATE;
> +extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
> +#define TRACE_TEST_BLAH_ENABLED 1
> +#define TRACE_TEST_WIBBLE_ENABLED 1
> +#include <lttng/tracepoint.h>
> +#include "trace-ust-testsuite.h"
> +
> +/* tracepoint_enabled() was introduced in LTTng UST 2.7 */
> +#ifndef tracepoint_enabled
> +#define tracepoint_enabled(a, b) true
> +#endif
> +
> +
> +#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
> +    tracepoint_enabled(qemu, test_blah) || \
> +    false)
> +
> +static inline void _nocheck__trace_test_blah(void *context, const char *filename)
> +{
> +    tracepoint(qemu, test_blah, context, filename);
> +}
> +
> +static inline void trace_test_blah(void *context, const char *filename)
> +{
> +    if (true) {
> +        _nocheck__trace_test_blah(context, filename);
> +    }
> +}
> +
> +#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
> +    tracepoint_enabled(qemu, test_wibble) || \
> +    false)
> +
> +static inline void _nocheck__trace_test_wibble(void *context, int value)
> +{
> +    tracepoint(qemu, test_wibble, context, value);
> +}
> +
> +static inline void trace_test_wibble(void *context, int value)
> +{
> +    if (true) {
> +        _nocheck__trace_test_wibble(context, value);
> +    }
> +}
> +#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
> diff --git a/tests/tracetool/ust.ust-events-c b/tests/tracetool/ust.ust-events-c
> new file mode 100644
> index 0000000000..db23224056
> --- /dev/null
> +++ b/tests/tracetool/ust.ust-events-c
> @@ -0,0 +1,14 @@
> +/* This file is autogenerated by tracetool, do not edit. */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +
> +#define TRACEPOINT_DEFINE
> +#define TRACEPOINT_CREATE_PROBES
> +
> +/* If gcc version 4.7 or older is used, LTTng ust gives a warning when compiling with
> +   -Wredundant-decls.
> + */
> +#pragma GCC diagnostic ignored "-Wredundant-decls"
> +
> +#include "trace-ust-all.h"
> diff --git a/tests/tracetool/ust.ust-events-h b/tests/tracetool/ust.ust-events-h
> new file mode 100644
> index 0000000000..4621a995fc
> --- /dev/null
> +++ b/tests/tracetool/ust.ust-events-h
> @@ -0,0 +1,56 @@
> +/* This file is autogenerated by tracetool, do not edit. */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER qemu
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./trace-ust.h"
> +
> +#if !defined (TRACE_TESTSUITE_GENERATED_UST_H) || \
> +     defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define TRACE_TESTSUITE_GENERATED_UST_H
> +
> +#include <lttng/tracepoint.h>
> +
> +/*
> + * LTTng ust 2.0 does not allow you to use TP_ARGS(void) for tracepoints
> + * requiring no arguments. We define these macros introduced in more recent * versions of LTTng ust as a workaround
> + */
> +#ifndef _TP_EXPROTO1
> +#define _TP_EXPROTO1(a)               void
> +#endif
> +#ifndef _TP_EXDATA_PROTO1
> +#define _TP_EXDATA_PROTO1(a)          void *__tp_data
> +#endif
> +#ifndef _TP_EXDATA_VAR1
> +#define _TP_EXDATA_VAR1(a)            __tp_data
> +#endif
> +#ifndef _TP_EXVAR1
> +#define _TP_EXVAR1(a)
> +#endif
> +
> +TRACEPOINT_EVENT(
> +   qemu,
> +   test_blah,
> +   TP_ARGS(void *, context, const char *, filename),
> +   TP_FIELDS(
> +       ctf_integer_hex(void *, context, context)
> +       ctf_string(filename, filename)
> +   )
> +)
> +
> +TRACEPOINT_EVENT(
> +   qemu,
> +   test_wibble,
> +   TP_ARGS(void *, context, int, value),
> +   TP_FIELDS(
> +       ctf_integer_hex(void *, context, context)
> +       ctf_integer(int, value, value)
> +   )
> +)
> +
> +#endif /* TRACE_TESTSUITE_GENERATED_UST_H */
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>


