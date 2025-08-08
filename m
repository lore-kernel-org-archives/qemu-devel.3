Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560FAC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 18:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukRbd-000516-Q8; Fri, 08 Aug 2025 14:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukRbU-0004y9-Kp
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:14:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukRbR-00014t-CW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:14:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6157b5d0cc2so3476310a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754676836; x=1755281636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hakzoAubzKi8fU79ntUfU6ucNjUI2bj2pJUL13iqB+s=;
 b=J9RExzEoCTeQ3eN7fE/lhKbvfRJuMkwQCQ3zplwfBusxq5gMsnip8jarGQDwTd1TP2
 +XQq5PITNrSvHkj9AT/eiQ/pOiWEvngh8+6h1IGWFpKqx3LwNcuBcoayvzm07ViBHN0f
 88pz8ok0vtG8jdOLoi7UbwH8KtRSALIwrQr3WVL/uZYJog2SZvQuwNZwpbjwFkEC3jrQ
 KHtY5JDRVmuF4yNcp3U9DrMKJTqmq0CWajlpUezLOAQ88yXe1QrQZIdzUnuS6g5sJ1Wz
 GMijb6VulRTdogfk+55tZr/KG3K0FSjPJGTrk7f3QTu7rt8q1K01/fi2XxLRh2F8GuGo
 3fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754676836; x=1755281636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hakzoAubzKi8fU79ntUfU6ucNjUI2bj2pJUL13iqB+s=;
 b=YSxbt8d8fi9b7L4oF+ZrFe5PTqGBUkrjfaxlYUSO28gs5o4SUzpWw++tpuCoRwaFJW
 II16/7Tn5Ilt4BHDSpPCNmb62RVTW4Ro6dqOiDGZg6D7SaicGR8gbuv6z8SSvYOOQn2E
 fpj+vUI2HXYOBBJ05luVVU6tneikGLbVWW0AQwbdKuTO8gfzHOre2kOq8hdh8jK1kFNp
 zPPSc3QPUS4qQ6vgTAtEKlUS3IU2m+typTyxIw/eLmz1Gt+ezThoDfy5HEinT/WMEUa1
 I/RwVxnNWKVBXMUn8tpGm6MUvRYrNN+Cn34WHy+D3DWdI6QP0ML8JjGNLGU3DeN2YLHk
 6DlA==
X-Gm-Message-State: AOJu0YyZsAQeTJsngYWQpnCQmZ/OpUizxQc9UUrKr0Kujm2wWPp5B1LK
 oAxVubWbpDH7/qSeIYQOoYXkJqDTcA7nju9V+Ux2DgjosRvvfXfFb0Wd//oUh0Yfr8kyxh3YPC5
 HTnC4bjwC7Xk0ppycToGtoEEAfobAx3Edex0SzHEHW66aitwB6wLBM2ZJjQ==
X-Gm-Gg: ASbGnct4nSmyXO2BiqboE4XFQxCmvYMAD03ah1E7+NrkNYnH0vL2V0BjjI6N6Xo2jE9
 Blo+1Ktb57q8chXBk5ZE2kbUrURQS+aWo9x24DBe81vF4feLcMd1kM40RDSsB7Fd4ZZGzHZwcml
 fTeHSMi89RH33eHQfCvTiokGNUtJY9eITiPX4cPs6UPr3277TRA8aPSv2oQDYj97U2zVVYyEOPe
 T6PbnoY
X-Google-Smtp-Source: AGHT+IHwuF6tbS+S36mnGXSJe/OGRMJr+Tlt87xqiXzSPRzc46Yey9LCWmU0KmvvTq1n6Gj4LGXTFgwUl+v/v9vGOFs=
X-Received: by 2002:a05:6402:324c:b0:615:4227:3b34 with SMTP id
 4fb4d7f45d1cf-617e2e75b26mr2765317a12.33.1754676836535; Fri, 08 Aug 2025
 11:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
 <t0o4ts.nym46t847yx5@linaro.org>
 <401440fc-c25b-4abc-94d2-4b21593c6eac@linaro.org>
In-Reply-To: <401440fc-c25b-4abc-94d2-4b21593c6eac@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Aug 2025 21:13:30 +0300
X-Gm-Features: Ac12FXz5I9eeCWltXDWpLX7G8DfqCYa2QpfO7ibRb_y3ix_x-cAx4k1S33BKofQ
Message-ID: <CAAjaMXbM_7rt_2dSjmZixcPs7=g3HU2yfJ-ZMvUJOtCeEaJZ9A@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>, 
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, Aug 8, 2025 at 9:03=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/8/25 2:11 AM, Manos Pitsidianakis wrote:
> > On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.or=
g> wrote:
> >> We implement tracing, following uftrace format.
> >> Trace is flushed every 32 MB, so file operations don't impact
> >> performance at runtime.
> >>
> >> A different trace is generated per cpu, and we ensure they have a uniq=
ue
> >> name, based on vcpu_index, while keeping room for privilege level comi=
ng
> >> in next commit.
> >
> > Suggestion (not a request): put some kind of documentation about the
> > format this patch implements, maybe a commit sha & URL to a header file
> > from upstream uftrace.
> >
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >> contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
> >> 1 file changed, 148 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> >> index d51faceb344..402a242433e 100644
> >> --- a/contrib/plugins/uftrace.c
> >> +++ b/contrib/plugins/uftrace.c
> >> @@ -12,6 +12,13 @@
> >> #include <qemu-plugin.h>
> >> #include <glib.h>
> >> #include <stdio.h>
> >> +#include <sys/stat.h>
> >> +#include <sys/time.h>
> >> +#include <time.h>
> >> +#include <unistd.h>
> >> +
> >> +#define MiB     (INT64_C(1) << 20)
> >> +#define NANOSECONDS_PER_SECOND 1000000000LL
> >>
> >> QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> >>
> >> @@ -24,6 +31,13 @@ typedef struct {
> >>      uint64_t frame_pointer;
> >> } CallstackEntry;
> >>
> >> +typedef struct {
> >> +    GArray *t;
> >> +    GString *path;
> >> +    GString *name;
> >> +    uint32_t id;
> >> +} Trace;
> >> +
> >> typedef struct Cpu Cpu;
> >>
> >> typedef struct {
> >> @@ -34,6 +48,7 @@ typedef struct {
> >> } CpuOps;
> >>
> >> typedef struct Cpu {
> >> +    Trace *trace;
> >>      Callstack *cs;
> >>      GByteArray *buf;
> >>      CpuOps ops;
> >> @@ -44,9 +59,41 @@ typedef struct {
> >>      struct qemu_plugin_register *reg_fp;
> >> } Aarch64Cpu;
> >>
> >> +typedef struct {
> >> +    uint64_t timestamp;
> >> +    uint64_t data;
> >> +} UftraceEntry;
> >> +
> >> +typedef enum {
> >> +    UFTRACE_ENTRY,
> >> +    UFTRACE_EXIT,
> >> +    UFTRACE_LOST,
> >> +    UFTRACE_EVENT
> >> +} UftraceRecordType;
> >> +
> >> static struct qemu_plugin_scoreboard *score;
> >> static CpuOps arch_ops;
> >>
> >> +static uint64_t gettime_ns(void)
> >> +{
> >> +#ifdef _WIN32
> >> +    /*
> >> +     * On Windows, timespec_get is available only with UCRT, but not =
with
> >> +     * MinGW64 environment. Simplify by using only gettimeofday on th=
is
> >> +     * platform. This may result in a precision loss.
> >> +     */
> >> +    struct timeval tv;
> >> +    gettimeofday(&tv, NULL);
> >> +    uint64_t now_ns =3D tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_us=
ec * 1000;
> >> +#else
> >> +    /* We need nanosecond precision for short lived functions. */
> >> +    struct timespec ts;
> >> +    timespec_get(&ts, TIME_UTC);
> >> +    uint64_t now_ns =3D ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_ns=
ec;
> >> +#endif
> >> +    return now_ns;
> >> +}
> >> +
> >> static Callstack *callstack_new(void)
> >> {
> >>      Callstack *cs =3D g_new0(Callstack, 1);
> >> @@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs=
)
> >>      return e;
> >> }
> >>
> >> +static Trace *trace_new(uint32_t id, GString *name)
> >> +{
> >> +    Trace *t =3D g_new0(Trace, 1);
> >> +    t->t =3D g_array_new(false, false, sizeof(UftraceEntry));
> >> +    t->path =3D g_string_new(NULL);
> >> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", i=
d);
> >> +    t->name =3D g_string_new(name->str);
> >> +    t->id =3D id;
> >> +    return t;
> >> +}
> >> +
> >> +static void trace_free(Trace *t)
> >> +{
> >> +    g_assert(t->t->len =3D=3D 0);
> >> +    g_array_free(t->t, true);
> >> +    t->t =3D NULL;
> >> +    g_string_free(t->path, true);
> >> +    t->path =3D NULL;
> >> +    g_string_free(t->name, true);
> >> +    t->name =3D NULL;
> >> +    g_free(t);
> >> +}
> >> +
> >> +static void trace_flush(Trace *t, bool append)
> >> +{
> >> +    int create_dir =3D g_mkdir_with_parents("./uftrace.data",
> >> +                                          S_IRWXU | S_IRWXG | S_IRWXO=
);
> >> +    g_assert(create_dir =3D=3D 0);
> >> +    FILE *dat =3D fopen(t->path->str, append ? "a" : "w");
> >> +    g_assert(dat);
> >> +    GArray *data =3D t->t;
> >> +    if (data->len) {
> >> +        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);
> >
> > fwrite might not write all bytes, how about using the
> > g_file_set_contents() wrapper?
> >
>
> If I see correctly, g_file_set_contents does not allow to append data,
> which is what we need to do here (that's the point of flushing every
> 32MB).

Ah you're right, my bad. It might be because it renames a temporary
file to the destination filename in order to make the operation
atomic.

> I can add an assert on fwrite return to make sure we wrote
> everything.

Or a while loop with a bytes_written counter.

Or keep it all in memory and write it on exit? Your call

