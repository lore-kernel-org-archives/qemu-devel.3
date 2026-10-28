Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE526606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=irpKiCrA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLx7E-0000ae-5c; Wed, 28 Oct 2026 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLx7C-0000aT-QO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLx79-0004ST-MY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793168781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrsqxuRZxMXx20SDexlCPC72cAj728EZeEDVAVowgTQ=;
 b=irpKiCrAg9DMDI1KXP5iMWekDZyeAJXiDgwWBrA+qEphILdZpmACys9q//A57Fu/r/YQyb
 XWZ7fws27ijEEXgwAphkRi1Vj0rlEQoqNcy9YZDZwJBStb4qHWsXUvvJ4gQzlUkKyCm2ZA
 YiQqUorBZjBn9EYatC4NnqmjulL9Ics=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-nhqqsd8fMsWfPipxJ0Il6A-1; Wed,
 28 Oct 2026 02:26:17 -0400
X-MC-Unique: nhqqsd8fMsWfPipxJ0Il6A-1
X-Mimecast-MFC-AGG-ID: nhqqsd8fMsWfPipxJ0Il6A_1793168776
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87869180059C; Wed, 28 Oct 2026 06:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD7861800495; Wed, 28 Oct 2026 06:26:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 83AC921E6A04; Wed, 28 Oct 2026 07:26:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: soumyajyotisarkar23@gmail.com
Cc: sarkarsoumyajyoti23@gmail.com,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Helge Deller <deller@kernel.org>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/8] ui/input: add high-resolution scroll input event
In-Reply-To: <20261027194256.76031-2-soumyajyotisarkar23@gmail.com>
 (soumyajyotisarkar's message of "Wed, 28 Oct 2026 01:12:49 +0530")
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
 <20261027194256.76031-2-soumyajyotisarkar23@gmail.com>
Date: Wed, 28 Oct 2026 07:26:13 +0100
Message-ID: <87tsm649yy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

soumyajyotisarkar23@gmail.com writes:

> From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
>
> The input layer can only describe wheel movement as WHEEL_UP/DOWN/
> LEFT/RIGHT button clicks, one per detent. Host UIs that receive
> smooth scroll deltas (touchpads, free-spinning or high-resolution
> wheels) have to round them to whole clicks and the guest never sees
> the finer movement.
>
> Add a new 'scroll' input event kind carrying a scroll axis (vertical
> or horizontal) and a distance in 1/120 of a wheel detent, the same
> unit Windows uses for WHEEL_DELTA and Linux for REL_WHEEL_HI_RES.
> Positive values scroll down or right.
>
> Scroll events are routed to the handler that receives pointer button
> events for the console. Handlers that do not set
> INPUT_EVENT_MASK_SCROLL keep working unchanged: the input core
> accumulates the distance and emits one wheel button click per full
> detent.

See [*] below.

> Also wire the new event into input-send-event, tracing and
> record/replay.
>
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>  include/ui/input.h    |  6 ++++
>  qapi/ui.json          | 45 ++++++++++++++++++++++--
>  replay/replay-input.c |  8 +++++
>  ui/input.c            | 82 ++++++++++++++++++++++++++++++++++++++++++-
>  ui/trace-events       |  1 +
>  5 files changed, 139 insertions(+), 3 deletions(-)
>
> diff --git a/include/ui/input.h b/include/ui/input.h
> index a1560cac0f..daedb547ff 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -9,6 +9,9 @@
>  #define INPUT_EVENT_MASK_REL   (1<<INPUT_EVENT_KIND_REL)
>  #define INPUT_EVENT_MASK_ABS   (1<<INPUT_EVENT_KIND_ABS)
>  #define INPUT_EVENT_MASK_MTT   (1<<INPUT_EVENT_KIND_MTT)
> +#define INPUT_EVENT_MASK_SCROLL (1 << INPUT_EVENT_KIND_SCROLL)
> +
> +#define INPUT_EVENT_SCROLL_DETENT 120
>  
>  #define INPUT_EVENT_ABS_MIN    0x0000
>  #define INPUT_EVENT_ABS_MAX    0x7FFF
> @@ -31,6 +34,7 @@ typedef struct QemuInputEvent {
>          InputMoveEvent rel;
>          InputMoveEvent abs;
>          InputMultiTouchEvent mtt;
> +        InputScrollEvent scroll;
>      };
>  } QemuInputEvent;
>  
> @@ -80,6 +84,8 @@ int qemu_input_scale_axis(int value,
>  void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value);
>  void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
>                            int min_in, int max_in);
> +void qemu_input_queue_scroll(QemuConsole *src, InputScrollAxis axis,
> +                             int value);
>  void qemu_input_queue_mtt(QemuConsole *src, InputMultiTouchType type, int slot,
>                            int tracking_id);
>  void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 9e3e80a3d7..e31fd74f87 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1120,6 +1120,34 @@
>                'axis'       : 'InputAxis',
>                'value'      : 'int' } }
>  
> +##
> +# @InputScrollAxis:
> +#     Scroll axis of a pointer input device.
> +#
> +# @vertical: vertical wheel
> +#
> +# @horizontal: horizontal wheel (pan)
> +#
> +# Since: 11.2
> +##
> +{ 'enum'  : 'InputScrollAxis',
> +  'data'  : [ 'vertical', 'horizontal' ] }

What's the difference to existing InputAxis?

> +
> +##
> +# @InputScrollEvent:
> +#     High-resolution scroll input event.
> +#
> +# @axis: Which scroll axis is referenced by @value.
> +#
> +# @value: Scroll distance in 1/120 of a wheel detent.  Positive
> +#     values scroll down (vertical) or right (horizontal).
> +#
> +# Since: 11.2
> +##
> +{ 'struct'  : 'InputScrollEvent',
> +  'data'  : { 'axis'    : 'InputScrollAxis',
> +              'value'   : 'int' } }
> +
>  ##
>  # @InputEventKind:
>  #
> @@ -1133,10 +1161,12 @@
>  #
>  # @mtt: a multi-touch input event
>  #
> +# @scroll: a high-resolution scroll input event (since 11.2)
> +#
>  # Since: 2.0
>  ##
>  { 'enum': 'InputEventKind',
> -  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt' ] }
> +  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt', 'scroll' ] }
>  
>  ##
>  # @InputKeyEventWrapper:
> @@ -1178,6 +1208,16 @@
>  { 'struct': 'InputMultiTouchEventWrapper',
>    'data': { 'data': 'InputMultiTouchEvent' } }
>  
> +##
> +# @InputScrollEventWrapper:
> +#
> +# @data: High-resolution scroll input event
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'InputScrollEventWrapper',
> +  'data': { 'data': 'InputScrollEvent' } }
> +
>  ##
>  # @InputEvent:
>  #     Input event union.
> @@ -1193,7 +1233,8 @@
>                'btn'     : 'InputBtnEventWrapper',
>                'rel'     : 'InputMoveEventWrapper',
>                'abs'     : 'InputMoveEventWrapper',
> -              'mtt'     : 'InputMultiTouchEventWrapper' } }
> +              'mtt'     : 'InputMultiTouchEventWrapper',
> +              'scroll'  : 'InputScrollEventWrapper' } }
>  
>  ##
>  # @input-send-event:
> diff --git a/replay/replay-input.c b/replay/replay-input.c
> index c86e00af0e..188c43a137 100644
> --- a/replay/replay-input.c
> +++ b/replay/replay-input.c
> @@ -45,6 +45,10 @@ void replay_save_input_event(QemuInputEvent *evt)
>          replay_put_dword(evt->mtt.axis);
>          replay_put_qword(evt->mtt.value);
>          break;
> +    case INPUT_EVENT_KIND_SCROLL:
> +        replay_put_dword(evt->scroll.axis);
> +        replay_put_qword(evt->scroll.value);
> +        break;
>      case INPUT_EVENT_KIND__MAX:
>          /* keep gcc happy */
>          break;
> @@ -80,6 +84,10 @@ QemuInputEvent *replay_read_input_event(void)
>          evt->mtt.axis = (InputAxis)replay_get_dword();
>          evt->mtt.value = replay_get_qword();
>          break;
> +    case INPUT_EVENT_KIND_SCROLL:
> +        evt->scroll.axis = (InputScrollAxis)replay_get_dword();
> +        evt->scroll.value = replay_get_qword();
> +        break;
>      case INPUT_EVENT_KIND__MAX:
>          /* keep gcc happy */
>          break;
> diff --git a/ui/input.c b/ui/input.c
> index f40a988370..f9ae49e275 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -181,7 +181,12 @@ void qmp_input_send_event(const char *device,
>      for (e = events; e != NULL; e = e->next) {
>          InputEvent *event = e->value;
>  
> -        if (!qemu_input_find_handler(1 << event->type, con)) {
> +        uint32_t mask = 1 << event->type;
> +
> +        if (event->type == INPUT_EVENT_KIND_SCROLL) {
> +            mask |= INPUT_EVENT_MASK_BTN;
> +        }
> +        if (!qemu_input_find_handler(mask, con)) {
>              error_setg(errp, "Input handler not found for "
>                               "event type %s",
>                              InputEventKind_str(event->type));
> @@ -217,6 +222,10 @@ void qmp_input_send_event(const char *device,
>              evt.mtt = *qapi->u.mtt.data;
>              break;
>  
> +        case INPUT_EVENT_KIND_SCROLL:
> +            evt.scroll = *qapi->u.scroll.data;
> +            break;
> +
>          default:
>              g_assert_not_reached();
>          }
> @@ -235,6 +244,7 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
>      InputBtnEvent *btn;
>      InputMoveEvent *move;
>      InputMultiTouchEvent *mtt;
> +    InputScrollEvent *scroll;
>  
>      if (src) {
>          idx = qemu_console_get_index(src);
> @@ -265,6 +275,12 @@ static void qemu_input_event_trace(QemuConsole *src, QemuInputEvent *evt)
>          name = mtt->axis < INPUT_AXIS__MAX ? InputAxis_str(mtt->axis) : "invalid";
>          trace_input_event_mtt(idx, name, mtt->value);
>          break;
> +    case INPUT_EVENT_KIND_SCROLL:
> +        scroll = &evt->scroll;
> +        name = scroll->axis < INPUT_SCROLL_AXIS__MAX ?
> +            InputScrollAxis_str(scroll->axis) : "invalid";
> +        trace_input_event_scroll(idx, name, scroll->value);
> +        break;
>      case INPUT_EVENT_KIND__MAX:
>          /* keep gcc happy */
>          break;
> @@ -342,12 +358,62 @@ static void qemu_input_queue_sync(QemuInputEventQueueHead *queue)
>      queue_count++;
>  }
>  
> +static void qemu_input_scroll_to_btn(QemuInputHandlerState *s,
> +                                     QemuConsole *src, QemuInputEvent *evt)
> +{
> +    static int residual[INPUT_SCROLL_AXIS__MAX];
> +    QemuInputEvent btn = { .type = INPUT_EVENT_KIND_BTN };
> +    InputScrollAxis axis = evt->scroll.axis;
> +
> +    if (axis >= INPUT_SCROLL_AXIS__MAX) {
> +        return;
> +    }
> +
> +    residual[axis] += evt->scroll.value;
> +    while (abs(residual[axis]) >= INPUT_EVENT_SCROLL_DETENT) {
> +        bool fwd = residual[axis] > 0;
> +
> +        if (axis == INPUT_SCROLL_AXIS_VERTICAL) {
> +            btn.btn.button = fwd ? INPUT_BUTTON_WHEEL_DOWN
> +                                 : INPUT_BUTTON_WHEEL_UP;
> +        } else {
> +            btn.btn.button = fwd ? INPUT_BUTTON_WHEEL_RIGHT
> +                                 : INPUT_BUTTON_WHEEL_LEFT;
> +        }
> +        residual[axis] -= fwd ? INPUT_EVENT_SCROLL_DETENT
> +                              : -INPUT_EVENT_SCROLL_DETENT;
> +
> +        btn.btn.down = true;
> +        qemu_input_event_trace(src, &btn);
> +        s->handler->event(s->dev, src, &btn);
> +        btn.btn.down = false;
> +        qemu_input_event_trace(src, &btn);
> +        s->handler->event(s->dev, src, &btn);
> +        s->events++;

Theoretical problem: counter overflow.  Existing code ignores it, so
ignoring it some more feels okay.

You send two events, but increment the event counter just once.
Checking its use...  looks like it's used like a bool.  Meh.  Not this
patch's problem.

Incrementing it twice could avoid triggering the reader's spider sense
for bugs.

> +    }
> +}
> +
>  void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
>  {
>      QemuInputHandlerState *s;
>  
>      qemu_input_event_trace(src, evt);
>

Special case "scroll event":

> +    if (evt->type == INPUT_EVENT_KIND_SCROLL) {
> +        s = qemu_input_find_handler(INPUT_EVENT_MASK_BTN |
> +                                    INPUT_EVENT_MASK_SCROLL, src);

Difference to the normal case: find handler for button or scroll, not
just scroll.

> +        if (!s) {
> +            return;
> +        }
> +        if (s->handler->mask & INPUT_EVENT_MASK_SCROLL) {

The handler can do scroll.  Send the event normally:

> +            s->handler->event(s->dev, src, evt);
> +            s->events++;
> +        } else {

[*] 

The handler can only do button.  Send suitable button events:

> +            qemu_input_scroll_to_btn(s, src, evt);

The function name suggests a conversion, but it's actually conversion
plus send.  Suggest something like
qemu_input_event_send_scroll_as_btn().

> +        }
> +        return;
> +    }
> +

Normal case: 

>      /* send event */

The comment is now stale.  Suggest to change it to

       /* Send event other than scroll */

and add

       /* Send scroll event */

right before your new code above.

>      s = qemu_input_find_handler(1 << evt->type, src);
>      if (!s) {
           return;
       }
       s->handler->event(s->dev, src, evt);
       s->events++;
   }
> @@ -518,6 +584,20 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
>      qemu_input_event_send(src, &evt);
>  }
>  
> +void qemu_input_queue_scroll(QemuConsole *src, InputScrollAxis axis,
> +                             int value)
> +{
> +    QemuInputEvent evt = {
> +        .type = INPUT_EVENT_KIND_SCROLL,
> +        .scroll = {
> +            .axis = axis,
> +            .value = value,
> +        },
> +    };
> +
> +    qemu_input_event_send(src, &evt);
> +}
> +
>  void qemu_input_queue_abs(QemuConsole *src, InputAxis axis, int value,
>                            int min_in, int max_in)
>  {
> diff --git a/ui/trace-events b/ui/trace-events
> index 339a61f341..638096607a 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -132,6 +132,7 @@ input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down
>  input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
>  input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
>  input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
> +input_event_scroll(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
>  input_event_sync(void) ""
>  
>  # sdl2-input.c


